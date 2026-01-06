

Kim Yarborough
kim.yarborough@randstaddigital.com
Working from home •‎ 5:30 PM EST
Kim Yarborough created this chat on Thursday, Sep 25
.
Space update:
History is on
Messages sent with history on are saved
Thursday, Sep 25
Kim Yarborough
,
Sep 25, 9:38 AM
,
Hey, Matt! I know we have met/talked yet, so we should do that soon ☺️

I would love to hear more about this "We have very few APIs to support this product". We should have only the APIs that are needed to support what we have built so far, so I'm curious to better understand.
,Sep 25, 9:38 AM,
Tuesday, Nov 25
Kim Yarborough
,
Nov 25, 11:58 AM
,
What was that “staying after class” thing about (after demo)?
,Nov 25, 11:58 AM,
Just curious if it was related to this morning’s discussion about data mapper
,Nov 25, 11:58 AM,
You (via Meet)
,
Nov 25, 12:45 PM
,

Huddle ended
,Nov 25, 12:45 PM,
You
,
Nov 25, 12:48 PM
,
https://cfi-nc.atlassian.net/wiki/spaces/KR/pages/4495605762/Data+Migration+Database+Schema
,Nov 25, 12:48 PM,
Wednesday, Dec 10
Kim Yarborough
,
Dec 10, 11:18 AM
,
Psst, over here
,Dec 10, 11:18 AM,
You (via Meet)
,
Dec 10, 11:18 AM
,

Huddle ended
,Dec 10, 11:18 AM,
You
,
Dec 10, 11:19 AM
,
Notice the time on the watch...during work time????
,Dec 10, 11:19 AM,
You
,
Dec 10, 12:05 PM
,
https://www.youtube.com/watch?v=taDALzJ-29c
YouTube videoPlay video
YouTube video
,Dec 10, 12:05 PM,
Kim Yarborough
,
Dec 10, 1:52 PM
,
duuuuuude
,Dec 10, 1:52 PM,
Thursday, Dec 11
You
,
Dec 11, 6:37 AM
,
quick summary call??
,Dec 11, 6:37 AM,
Kim Yarborough
,
Dec 11, 6:37 AM
,
sure
,Dec 11, 6:37 AM,
Kim Yarborough (via Meet)
,
Dec 11, 6:37 AM
,

Huddle ended
,Dec 11, 6:37 AM,
You
,
Dec 11, 6:55 AM
,
Jacqui: optimistic of current plan
qBuilder: build vs buy
MetaBase for on demand queries
Follow-up on topic of workflows
KY: what needs to be done?
Q: Identify the workflows
Reference Data
Communication Templates
Task Types/SubTypes
Workflow Definitions (tasks, Recipients (Assignment), BRs, Comms, 3rd-party, etc.)
Information may be scattered in Jira, Confluence, Excel, etc.
Database, events, dependencies
DevOp Concerns
Curate a list of Workflows for K12 Project
By User Type
Workflow diagram, domain model, Azure landscape
Attempt to implement a workflow in PI —> recipe
Task System Refactor to support task types, status flows
Communication Template(s)
Copy/Content
Association with Workflow/Task
Q: Rework and/or refactoring for Task Engine
,Dec 11, 6:55 AM,
Monday, Dec 15
You
,
Dec 15, 2:52 PM
,
Edited,
Hey, I just wanted to give you a heads up regarding the spike on the workflow automation story.

I met with Terry and Matthew Cummings today . For the task automation effort there is a body of work that will entail some Azure set up; workflow orchestration tooling, definition, and database; and changes to the task system to support automation.

We started outlining the work at a high-level in a confluence page.  Some of the work is already in progress and has overlap with the worker is doing for the Docker Containerization.

Let me know when you have about 10 minutes or so I can run through the items with you

,Dec 15, 2:52 PM,Edited,
Kim Yarborough
,
Dec 15, 2:54 PM
,
Ok let’s talk tomorrow. I’ve logged off for today
,Dec 15, 2:54 PM,
You
,
Dec 15, 3:00 PM
,
Sounds good, thanks
,Dec 15, 3:00 PM,
You (via Meet)
,
Dec 22, 10:18 AM
,

Huddle ended
,Dec 22, 10:18 AM,
You
,
Dec 22, 10:47 AM
,



Seed only the reference data
Database project
Core tables | objects
Reference data
DACPAC environment variables
Test data: 
More of it, changes frequently;
Manage differently; not in the current database project
Use different mechanisms (Postman, APIs)



Maintenance challenges
Seeding data for communication center; generating diverse record(s)
Communication  records in various states for “Development”
“Testing”; test suites create their own records/data without “seeding”



(3) Household in seeded - Luke has to create the Entra; 
Need 10 or 20; 2000;
Need features that work with real data
Future features;
Need to understand the gaps to continue moving forward with sequential feature development
Security


Need “seeding” process for 1000/s of Household and Students

T-SQL or tool (Redgate); mechanism to seed data
Volume of data; with variations
With sample Entra accounts + include these tables
School (5):
Create a School, we can create the Entra account programmatically;
Providers (5) 


Plan:

Current delivery cycle - how?
Setup the foundation; ground-zero mentality
Pull-back on current work with action items
,Dec 22, 10:47 AM,
Plan:

Current delivery cycle - how?
Focus on true sequential development of features
Enrollment Builder
Not functional; not production ready
No validation.
Setup the foundation; ground-zero mentality for feature work
Login/credentials (security)
Application workflow(s) sequencing
Application registration for Scholarship
School selection
Document uploads
Lottery
Awarding
Roster
Workflow Orchestration

    •        ⁃    Pull-back on current work with action items
,Dec 22, 10:47 AM,
Kim Yarborough
,
Dec 22, 11:22 AM
,
i lost you
,Dec 22, 11:22 AM,
You
,
Dec 22, 11:22 AM
,


Jill Sorg

6:35 AM (4 hours ago)

Good morning Matt - 

In prep for this afternoon's conversation on regarding what it will take to give us confidence in our k12 Roadmap:  

JK and Brandon are diving in a bit this AM to look at what's actually been done to date, what remains an any adjustments to ordering of work to be more efficient, so that will be a helpful input.

Matt - when we talked on Friday, I understood that your confidence would go up significantly if we could address the two risks you highlighted around data seeding and workflow engine.  I think you were going to share some add'l information about that second piece - some things that would help me.   Don't take these as argumentative, but I'm trying make this afternoon's conversation as efficient as possible.

1.In Layman's terms:  What is the problem that this solves (and how does it increase your confidence in getting K12 done in time)? SEEDING: SOLVES THE ISSUE THAT THERE IS NO INITIAL DATA INPUT (NO ENROLLMENT BUILDER/DATA MAPPER WITH APPLICATION REGISTRATIONS). WE NEED MORE VOLUME TO VERIFY USE CASES, LOTTERY, AND AWARDING PROCESSES. WE CAN THEN IMPLEMENT EARLY WORKFLOWS AND AUTOMATION - TO TRIGGER EVENTS SUBSEQUENT. THERE IS NO STUDENT DATA CONNECTED TO THE HOUSEHOLD RECORDS WITHOUT SEEDING DATA. IMPACT TO PROCESS AN APPLICATION. DOES HOUSEHOLD REGISTRATION NOT INCLUDE ADDING STUDENTS AND APPLYING FOR A SCHOLARSHIP(S). THEN GOING BACK TO EB VIA TASKS AFTER INITIAL REGISTRATION TO SETUP STUDENTS, SELECT SCHOLARSHIP PROGRAM, AND SELECT SCHOOL.
 
2.From the devil's advocate pov:  What are the risks that Rex can't get it done?  Does he have all the information he needs to get it done?   Does this require dev training?  Rex POC for the workflow orchestration only. THE BE NEEDS TO PROVIDE THE TOOLS, RECIPE STO AUTOMATE A WORKFLOW/TASK(S) WITH COMMUNICATION(S) ETC.; ALL IT STAKEHOLDERS KNEW THE TASK ENGINE WAS NON-FUNCTIONAL EARLY ON WITHOUT ANY CONCEPT OF ORCHESTRATION; IS IT AN UNREALISTIC EXPECTATION TO NOT PROVIDE WHAT THE TASK ENGINE NEEDS TO HAVE TO BE OPERATIONAL.

3. Playing the other side of the coin:   Is this NECESSARY or a just a best practice.   Could we achieve MVP without it?  If so what would have to be true to do that? THE MVP REQUIRES THE ORCHESTRATION OF OUR “TASKS” - OUR AZURE/EVENT-DRIVEN FLOWS WERE A DEFINED DELIVERABLE

4.  On the data seeding topic - i do see the value in having sufficient data in dev to test, but if i understood correctly, you were talking about seeding close to full volume data in development environment  and I have some concerns, questions about that

Will it bog down system - slowing down unit testing; NO, IT WILL IDENTIFY CURRENT UI AND PERFORMANCE ISSUES.
If we change schema (since that's still evolving) - won't that take significant time each time we make an update ONLY SEED DATA WITHOUT SCHEMA CHANGES; EXPECT THE SCHEMAS TO CHANGE INCREMENTAL AS FEATURES DEVELOP (SHOULD BE MINIMAL IMPACT)
Could actually make bug resolution longer to figure out where the bug is

Perhaps I misunderstood your intent, but want to make sure we're pursuing a minimum solution that meets the need. NO.
,Dec 22, 11:22 AM,
You
,
Dec 22, 11:32 AM
,


Jill Sorg

6:35 AM (4 hours ago)

Good morning Matt - 

In prep for this afternoon's conversation on regarding what it will take to give us confidence in our k12 Roadmap:  

JK and Brandon are diving in a bit this AM to look at what's actually been done to date, what remains an any adjustments to ordering of work to be more efficient, so that will be a helpful input.

Matt - when we talked on Friday, I understood that your confidence would go up significantly if we could address the two risks you highlighted around data seeding and workflow engine.  I think you were going to share some add'l information about that second piece - some things that would help me.   Don't take these as argumentative, but I'm trying make this afternoon's conversation as efficient as possible.

1.In Layman's terms:  What is the problem that this solves (and how does it increase your confidence in getting K12 done in time)? SEEDING: SOLVES THE ISSUE THAT THERE IS NO INITIAL DATA INPUT (NO ENROLLMENT BUILDER/DATA MAPPER WITH APPLICATION REGISTRATIONS). WE NEED MORE VOLUME TO VERIFY USE CASES, LOTTERY, AND AWARDING PROCESSES. WE CAN THEN IMPLEMENT EARLY WORKFLOWS AND AUTOMATION - TO TRIGGER EVENTS SUBSEQUENT. THERE IS NO STUDENT DATA CONNECTED TO THE HOUSEHOLD RECORDS WITHOUT SEEDING DATA. IMPACT TO PROCESS AN APPLICATION. DOES HOUSEHOLD REGISTRATION NOT INCLUDE ADDING STUDENTS AND APPLYING FOR A SCHOLARSHIP(S). THEN GOING BACK TO EB VIA TASKS AFTER INITIAL REGISTRATION TO SETUP STUDENTS, SELECT SCHOLARSHIP PROGRAM, AND SELECT SCHOOL.
 
2.From the devil's advocate pov:  What are the risks that Rex can't get it done?  Does he have all the information he needs to get it done?   Does this require dev training?  Rex POC for the workflow orchestration only. THE BE NEEDS TO PROVIDE THE TOOLS, RECIPES TO AUTOMATE A WORKFLOW/TASK(S) WITH COMMUNICATION(S) ETC.  THE TASK ENGINE IS LIMITED IN CURRENT FUNCTIONALITY; AND REQUIRES A CONCEPT OF ORCHESTRATION; THE TASK SYSTEM REQUIRES THE ABILITY TO AUTOMATE CREATE NEW/ASSIGN TASKS, SEND COMMUNICATIONS, AND TO HAVE A TASK TRIGGER SUBSEQUENT EVENTS. 

3. Playing the other side of the coin:   Is this NECESSARY or a just a best practice.   Could we achieve MVP without it?  If so what would have to be true to do that? THE MVP REQUIRES THE ORCHESTRATION OF OUR “TASKS” - OUR AZURE/EVENT-DRIVEN FLOWS WERE A DEFINED DELIVERABLE. ALL ITEMS LISTED IN #2 IS PART OF MVP. 

4.  On the data seeding topic - i do see the value in having sufficient data in dev to test, but if i understood correctly, you were talking about seeding close to full volume data in development environment  and I have some concerns, questions about that

Will it bog down system - slowing down unit testing; NO.  HOWEVER IF IT DOES, IT WILL IDENTIFY CURRENT UI AND PERFORMANCE ISSUES NOW/EARLY. NOTE: CURRENT DATA GRIDS LOAD ALL DATA AND PAGINATE LOCALLY; REQUIRES REFACTOR.
If we change schema (since that's still evolving) - won't that take significant time each time we make an update ONLY SEED DATA WITHOUT SCHEMA CHANGES; EXPECT THE SCHEMAS TO CHANGE INCREMENTAL AS FEATURES DEVELOP (SHOULD BE MINIMAL IMPACT).
Could actually make bug resolution longer to figure out where the bug is

Perhaps I misunderstood your intent, but want to make sure we're pursuing a minimum solution that meets the need. NO. WE NEED TO SOCIALIZE OUR SEEDING STRATEGY. NEED TO SEPARATE THE APPLICATION SPECIFIC (CORE TABLES, REFERENCE DATA) FROM THE “SEEDED” DATA TO SIMULATE THE OPERATIONAL DATA. NEED TO DETERMINE IF ANY WHAT TOOLS WE USE TO MANAGE THIS PROCESS.
,Dec 22, 11:32 AM,
Tuesday, Dec 23
You (via Meet)
,
Dec 23, 10:36 AM
,

Huddle ended
,Dec 23, 10:36 AM,
You
,
Dec 23, 5:43 PM
,
https://www.instagram.com/reel/DSlxEJEkw26/?igsh=MTkwcXI2YXdrOHh0cg==
,Dec 23, 5:43 PM,
Monday, Dec 29
Kim Yarborough
,
Dec 29, 12:49 PM
,
this kind of stuff makes me postal
,Dec 29, 12:49 PM,
You
,
Dec 29, 3:20 PM
,
Are you talking about the ART Sync??? 🙂
,Dec 29, 3:20 PM,
Kim Yarborough
,
Dec 29, 4:11 PM
,
I was
,Dec 29, 4:11 PM,
Wednesday, Dec 31
Kim Yarborough
,
Wed 12:16 PM
,
bahahaha!!!
image.png
,Wed 12:16 PM,
You
,
Wed 1:17 PM
,
Nice… phone number originating from Colorado. I promise I did not send this out to you.🤐
,Wed 1:17 PM,
I will take the $1000 every four work days though
,Wed 1:18 PM,
Kim Yarborough
,
Wed 1:18 PM
,
i like the 60-90 min per day though
,Wed 1:18 PM,
You
,
Wed 1:19 PM
,
I’ll create a AI agent to automate this… Then it’ll just work for me while I’m at the K-12 project

,Wed 1:19 PM,
Kim Yarborough
,
Wed 1:19 PM
,
alas, still not enough to support my extravagant lifestyle 😂
,Wed 1:19 PM,
You
,
Wed 1:19 PM
,
It is still good taco money though

,Wed 1:19 PM,
Kim Yarborough
,
Wed 1:19 PM
,
alright, I'm calling it a year - Happy New Year to ya!
,Wed 1:19 PM,
You
,
Wed 1:20 PM
,
Same to you! Enjoy!!!
Message read by Kim Yarborough


,Wed 1:20 PM,
Message Kim Yarborough

