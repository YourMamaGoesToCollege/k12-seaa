# @buildmotion/version-check

[![npm version](https://badge.fury.io/js/%40buildmotion%2Fversion-check.svg)](https://badge.fury.io/js/%40buildmotion%2Fversion-check)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive Angular library for detecting application version mismatches in deployed environments. Essential for single-spa micro-frontends and long-running SPAs to prevent stale client code from causing runtime errors.

## Features

- ✅ **Multiple Detection Strategies**: Polling, Service Worker, Window Focus, Route Changes
- ✅ **Flexible Version Sources**: HTTP endpoints, Service Worker, Custom strategies
- ✅ **Observable & Signals API**: Support for both RxJS and Angular Signals
- ✅ **Configurable Comparison**: Built-in strategies for semantic versions, git hashes, and build numbers
- ✅ **Single-SPA Support**: Designed for micro-frontend architectures
- ✅ **TypeScript First**: Fully typed with comprehensive interfaces
- ✅ **Enterprise Ready**: Follows CLEAN architecture and SOLID principles
- ✅ **Extensible**: Custom comparison strategies and version sources

## Installation

```bash
npm install @buildmotion/version-check
# or
yarn add @buildmotion/version-check
```

## Quick Start

### 1. Generate Version File

Create a `version.json` file during your build process:

```json
{
  "version": "1.2.3",
  "buildTimestamp": "2024-01-15T10:30:00Z",
  "gitHash": "a1b2c3d4",
  "environment": "production"
}
```

### 2. Configure Your Application

```typescript
import { ApplicationConfig } from '@angular/core';
import { provideVersionCheck } from '@buildmotion/version-check';

export const appConfig: ApplicationConfig = {
  providers: [
    provideVersionCheck({
      enabled: true,
      checkInterval: 60000, // Check every minute
      versionEndpoint: '/version.json',
      autoPromptUser: true,
    }),
  ],
};
```

### 3. Use in Your Component

```typescript
import { Component, OnInit } from '@angular/core';
import { VersionCheckService } from '@buildmotion/version-check';

@Component({
  selector: 'app-root',
  template: `
    <div *ngIf="hasMismatch()" class="update-banner">
      New version available!
      <button (click)="reload()">Update Now</button>
    </div>
  `,
})
export class AppComponent implements OnInit {
  hasMismatch = this.versionCheck.hasMismatch;

  constructor(private versionCheck: VersionCheckService) {}

  ngOnInit() {
    this.versionCheck.startPolling();

    this.versionCheck.versionMismatch$.subscribe((event) => {
      console.log('Version mismatch detected:', event);
    });
  }

  reload() {
    window.location.reload();
  }
}
```

## Version Comparison Strategies

The library provides three built-in strategies for comparing versions. Choose the one that best fits your deployment workflow.

### Git Hash Strategy (Recommended)

Compares git commit hashes to detect version changes. Most reliable for tracking exact source code versions.

```typescript
import { GitHashComparisonStrategy } from '@buildmotion/version-check';

provideVersionCheck({
  comparisonStrategy: new GitHashComparisonStrategy(),
  versionEndpoint: '/version.json'
});
```

**When to use:**
- You want to track exact source code versions
- Your CI/CD injects git commit hashes
- You need cross-environment consistency
- You want to detect rebuilds from the same source

**Key features:**
- Uses full 40-character SHA-1 or 64-character SHA-256 hashes
- Falls back to semantic version if git hash unavailable
- Works with CI/CD environment variables (GITHUB_SHA, CI_COMMIT_SHA, etc.)

### Build Number Strategy

Compares numeric build numbers from CI/CD pipelines. Best for sequential deployment tracking.

```typescript
import { BuildNumberComparisonStrategy } from '@buildmotion/version-check';

provideVersionCheck({
  comparisonStrategy: new BuildNumberComparisonStrategy(),
  versionEndpoint: '/version.json'
});
```

**When to use:**
- Your CI/CD auto-increments build numbers
- You want simple, sequential version tracking
- You need to distinguish rebuilds from same commit
- You have a single deployment pipeline

**Key features:**
- Works with GitHub Actions, GitLab CI, Jenkins, Azure Pipelines
- Handles build number 0 correctly
- Falls back to semantic version if build number unavailable

### Default Strategy

Simple string equality comparison. Works with any version format.

```typescript
import { DefaultVersionComparisonStrategy } from '@buildmotion/version-check';

provideVersionCheck({
  comparisonStrategy: new DefaultVersionComparisonStrategy(),
  versionEndpoint: '/version.json'
});
```

**When to use:**
- You have a simple versioning scheme
- You use semantic versioning without complex logic
- Version strings are guaranteed unique per deployment

## CI/CD Integration

### GitHub Actions

```yaml
- name: Generate Version File
  run: |
    echo "{
      \"version\": \"${{ github.ref_name }}\",
      \"gitHash\": \"${{ github.sha }}\",
      \"buildNumber\": ${{ github.run_number }},
      \"buildTimestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",
      \"environment\": \"production\"
    }" > src/assets/version.json

- name: Build Application
  run: npm run build
```

### GitLab CI

```yaml
generate-version:
  script:
    - |
      cat > src/assets/version.json << EOF
      {
        "version": "${CI_COMMIT_TAG:-${CI_COMMIT_SHORT_SHA}}",
        "gitHash": "${CI_COMMIT_SHA}",
        "buildNumber": ${CI_PIPELINE_IID},
        "buildTimestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
        "environment": "${CI_ENVIRONMENT_NAME}"
      }
      EOF
```

### Jenkins

```groovy
stage('Generate Version') {
  steps {
    script {
      def versionJson = """
      {
        "version": "${env.TAG_NAME ?: env.GIT_COMMIT.take(7)}",
        "gitHash": "${env.GIT_COMMIT}",
        "buildNumber": ${env.BUILD_NUMBER},
        "buildTimestamp": "${new Date().format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'')}",
        "environment": "production"
      }
      """
      writeFile file: 'src/assets/version.json', text: versionJson
    }
  }
}
```

### Azure Pipelines

```yaml
- script: |
    echo {
      "version": "$(Build.SourceBranchName)",
      "gitHash": "$(Build.SourceVersion)",
      "buildNumber": $(Build.BuildNumber),
      "buildTimestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
      "environment": "$(Build.production)$"
    } > src/assets/version.json
  displayName: 'Generate Version File'
```

## Best Practices

### Version File Generation

1. **Automate in CI/CD**: Always generate version files in your build pipeline
2. **Use full git hashes**: Prefer 40-character SHA-1 over short hashes
3. **Include multiple identifiers**: Combine version, gitHash, and buildNumber for traceability
4. **Add artifact checksums**: For exact artifact verification, include SHA256 in metadata

### Version Comparison

1. **Choose the right strategy**: 
   - Git Hash: Best for source tracking
   - Build Number: Best for sequential tracking
   - Default: Simplest, works with any format
2. **Handle missing data**: All strategies fall back gracefully
3. **Test endpoint availability**: Ensure `/version.json` is accessible in production

### User Experience

1. **Preserve user work**: Save state before prompting reload
2. **Use clear messages**: Explain why refresh is needed
3. **Avoid forced reloads**: Let users decide when to update
4. **Check polling interval**: Balance freshness with performance (default: 60 seconds)

### Security

1. **No sensitive data**: Keep credentials and secrets out of version files
2. **Static file serving**: Serve version.json as a static asset
3. **CORS configuration**: Configure properly for cross-origin requests
4. **Rate limiting**: Prevent abuse of version endpoint

## Documentation

For complete documentation, see [Version Check Specification](../../.spec-motion/version-check.specification.md).

## Support

- **Documentation**: [GitHub Repository](https://github.com/buildmotion/buildmotion)
- **Issues**: [GitHub Issues](https://github.com/buildmotion/buildmotion/issues)
- **Email**: matt.vaughn@buildmotion.com

## License

MIT © [Build Motion](https://www.buildmotion.com)