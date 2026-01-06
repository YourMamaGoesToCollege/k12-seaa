

Phillip Von Gretener
phillip.vongretener@randstaddigital.com
Working from home •‎ 5:23 PM EST
Phillip Von Gretener created this chat on Tuesday, Sep 23
.
Space update:
History is on
Messages sent with history on are saved
Tuesday, Sep 23
Phillip Von Gretener
,
Sep 23, 1:25 PM
,
I'm curious about your thoughts on this
image.png
,Sep 23, 1:25 PM,
Wednesday, Sep 24
Phillip Von Gretener
,
Sep 24, 9:03 AM
,
Hi. I'd like a response to this please.
,Sep 24, 9:03 AM,
Additional comment Elton added just now. I haven't responded to his first note yet, as I'd like your input.
image.png
,Sep 24, 9:05 AM,
You
,
Sep 24, 9:45 AM
,
Hi Phillip, reading through the comments here from Elton. It sounds like he is experiencing some difficulties at this time. First, I want to say I value everyone on the team and their contributions and efforts. We have a backend system that is required to support (4) applications. I feel like the capabilities of the team members can meet this challenge.

At this point, I have. indicated that we need to review the documentation being prepared for the Micro Services. In my discussions with Robert, Elton, and Terry;  I have only asked why we are proposing this particular solution (root cause). I agree that the scaling capabilities would solve the noted problem/issue. My concern is to determine if this solutions is required for the "rest" of the application(s). 

From my understanding, one of the main reasons for the K12 project is to resolve the load/performance issues of the application during the registration and/or high-volume periods. During the last week, I've talked to our team members about the this issue particularly. Whether it is Microservices or not - there has to be a solution to manage the backend services for the different applications. 

I have no decision at this point. Mostly due to allow Elton to finish the documentation on the Microservice findings. Currently, the document is not in Confluence and has not been peer-reviewed. I am hoping it speaks to the problem we are tying to solve with the solution. I am still waiting on Elton to schedule the review of the documentation.

To keep things open, we should consider:

1. the specific problem we are solving.
2. the granularity of the microservices.
3. the Azure tools used to manage the solution.
,Sep 24, 9:45 AM,
You
,
Sep 24, 9:53 AM
,
Just to clarify, Microservices are not off the table at this time. It is an architectural and structural concern for the system. There are some business and technical aspects that effect this as well. I can review what I know with you and Jill if you would like.
,Sep 24, 9:53 AM,
Phillip Von Gretener
,
Sep 24, 12:26 PM
,
Thank you, that really helps. No, you do not need to involve me or Jill in that decision. That is entirely up to you and your team. Assuming, obviously, it does not influence overall risk, budget, or timeline, in which case I would need to make sure I can compensate for that. That being said, would you do me a favor and provide some additional clarification and direction to Elton, who is clearly concerned and struggling. I have not yet responded to his messages, and if it's all right with you, I will let him know that you plan to do so. Sound good?
,Sep 24, 12:26 PM,
You
,
Sep 24, 4:05 PM
,
Hi, good afternoon. I had a good conversation with Elton and Terry this afternoon. I have notes and some action items we need to do. I think most of the situation might be communication related; and also that Elton could have been more proactive in getting requirements/details information surrounding the proposed solution. 

I would like to give you and Jill an update. I also need to check-in with Jacqui to figure out how to get some time from some of team members on the dev-teams (also Ananda and Eric) during PI3 for some support.

I hope Elton feels better. He seemed relieved and in better spirits at the end of our discussion today.
,Sep 24, 4:05 PM,
Phillip Von Gretener
,
Sep 24, 4:06 PM
,
That's great news! I appreciate you doing that. Elton is emotional, but by all indication is he's also quite talented. I think he just needs some direction. I'll take the action item to get some time set up for you me Jacqui and Jill ASAP.
,Sep 24, 4:06 PM,
You
,
Sep 24, 4:07 PM
,
Sounds good! Have a good night.
,Sep 24, 4:07 PM,
Friday, Sep 26
Phillip Von Gretener
,
Sep 26, 7:35 AM
,
I'm missing another important call to be here. Will you be attending?
,Sep 26, 7:35 AM,
Phillip Von Gretener
,
Sep 26, 10:29 AM
,
This came in from Bradley. Sorry, not much time for you to read it, but for your reference. 

There are 4 disconnected dev teams, architecture, and devOps
all working without a functional specification.  The design is determined
as we go with little input from someone familiar with the technical aspects and
existing back-end design.  Not one person is familiar with the entire
design as it exists, or where it's going.  My experience with Robert as an
architect is his frustration, and insistence that I do not ask him any more of
these questions, and that I should go to Jacqui to understand "the
vision".  The requirements are Figmas, which are a front-end artifact
for mockup, and then often extremely vague details around outcome required.
 Those Figmas are provided to each team independently (unknown to the
others) and are often incorrect.  They include things like grids with
provider specific data in them, yet if we're lucky enough, we may understand
that this functionality is global across all program partner types.  We
spend a lot of time pushing back on requirements and mockups (or unfortunately
re-doing work) because those don't reflect reality or the intended global
design.  

It is 100% up to each back-end person in each silo to invent how that work will
be implemented because there isn't anyone in the process that defines it.
 Many questions are left unanswered in terms of how this SHOULD work,
including various edge-cases and "what-ifs" (because again, nobody
understands the full scope).  When that work is done, those design
decisions don't trickle into how we do things as a unified back-end for this
software.  To ask for each unit of completed work to be communicated
amongst each team is a huge bottleneck.  Each disconnected back-end team
member understands just enough and has their own opinion of how this should
work, which will often result in a debate. Nobody provides architecture
guidance at that level.  

I've spent more time than I should trying to coalesce around practices and
needs for the group.  I've volunteered my time to invent solutions for
automation, to solve other people's problems, and to own certain aspects of
back-end rework or maintenance to ensure that this goes smoothly. One might
think that "leading by example" might inspire others to do the same.
 Instead, I've become "answers man".  Back-end sync is
mostly me trying to encourage participation and bringing what I feel is
important.  Occasionally people will bring their own topics, but often
others don't engage with the topic at hand.  It's been moderately helpful
to establish a working relationship with these people, but it doesn't mitigate
the issues we have around planning or aligning on design.  

Collaboration and communication have suffered greatly since Covid, and
leveraging tools such as Teams to facilitate those things feels insufficient.
 I only speak with my other teammates about specific project related
functionality.  Most of my time is back-end architecture, infrastructure,
and best efforts to exchange information with other people that share my
skillset so that we are making sound decisions.  Silos are an extremely
bad choice in this climate, and I'm certain that much of this has been said out
loud on several occasions.  We allocate 2 separate meetings per week to
ensure that we're in sync to a degree (leads and back-end sync). While these
meetings are often productive; they won't address the shortcomings around holistic
planning as we go, sparse technical details, and a lack of transparency or
cohesion across silos within the same discipline. We're all here bringing
experience and expertise from elsewhere, but "industry standard" this
is not....
,Sep 26, 10:29 AM,
Saturday, Sep 27
Phillip Von Gretener
,
Sep 27, 12:12 PM
,
I'm going to shoot for 10/8 and 10/9 for the trip to Raleigh. You, Robert, and Phillip Cartwright. Should I also invite Elton? Is he central to this conversation?
,Sep 27, 12:12 PM,
Monday, Sep 29
You
,
Sep 29, 9:06 AM
,
Hi Phillip - I think this group is good for the "starter" conversation. My concerns is that we are missing an architect here - not sure of the on-going impact of (2) critical architects not being able to work or communicate together. In order to resolve the issues of communication, process, and analysis/design (mentioned above), all architects including Elton has to do "architect" level work - this will be critical to meet our deliverables.

One of the main issues mentioned is the availability of detailed requirements. What are your thoughts on the way/mechanism or level-of-detail of how we get requirements from our client?
,Sep 29, 9:06 AM,
Phillip Von Gretener
,
Sep 29, 9:12 AM
,
Regarding your first point --- I find it immensely gratifying that you have come to the same conclusion I have come to with respect to the Architects. The problem for me is that I'm not an architect or technical at all, so I definitely didn't feel I could drive that conversation authoritatively. And when neither Robert nor Elton were able to support the conversation things really came to a halt. I am prepared to support whatever you would like to do to remedy your first point above, up to an including replacing Elton or Robert as needed. I'd be delighted to be a sounding board for you as you work through your solution, but I don't want you to feel constrained by me either. Let me know how I can support you. At the very least, Elton is going to have to have a come to Jesus.
,Sep 29, 9:12 AM,
Phillip Von Gretener
,
Sep 29, 9:14 AM
,
Regarding your second point -- you probably saw my frustration on Friday afternoon. Sorry about that. It had been a very long and stressful week, and I am very frustrated with that particular conversation. That being said, I think you and I need to take a bit of time and discuss the specific outcome that you would like to drive towards, and the practices and disciplines you would like to put in place to achieve it. I can then drive it from my end in terms of setting up the framework and driving the expectations. Shall I look for a bit of time on our calendar to discuss this after PI planning is complete this week?
,Sep 29, 9:14 AM,
You
,
Sep 29, 9:45 AM
,
Yes, let's discuss the "requirements" conversation after PI planning. I have a concern about "Enrollment Builder" - that can be used as an example. This may warrant a separate conversation with you and Jill.
,Sep 29, 9:45 AM,
Phillip Von Gretener
,
Sep 29, 9:49 AM
,
(the following I had started typing, but I had to shift attention when the demo started. I think it aligns well with your response)      ---        Also, Jacqui shared with me some of your technical design concerns about K12. Just know that this does not come as a surprise, and I'm very open to any solutions or course corrections you may have. Up until now I haven't had anybody capable of evaluating and driving these potential changes.
,Sep 29, 9:49 AM,
Phillip Von Gretener
,
Sep 29, 11:04 AM
,
As you are probably already aware, Bradley Larson quit on Friday. I've been getting the vibe from him for a while that that was probably his plan. He had some very legitimate frustrations, and some excellent advice, but he got frustrated before he was able to drive change. I would like to have a conversation with you about two things stemming from your comments above and Bradley's exit. First, the role of Architects, which I believe you and I are aligned on and now we need to drive. And the second is whether or not we need a lead developer role. It was my understanding early on that the developers would communicate naturally with each other via community of practice and through the architects, but clearly that didn't happen. We need to drive change quickly. We're behind the curve, and I fear we are going to start shedding our reliable people like Bradley.
,Sep 29, 11:04 AM,
Tuesday, Sep 30
Phillip Von Gretener
,
Sep 30, 7:14 AM
,
is this in scope/helpful for this convo?
,Sep 30, 7:14 AM,
Phillip Von Gretener
,
Sep 30, 8:50 AM
,
Feedback please :-)
,Sep 30, 8:50 AM,
Phillip Von Gretener
,
Oct 1, 9:06 AM
,
I'd like to catch up at some point today. What's your availability?
,Oct 1, 9:06 AM,
You
,
Oct 1, 1:23 PM
,
I have nothing but availability from this point forward.
,Oct 1, 1:23 PM,
You
,
Oct 1, 2:50 PM
,
Would you want to catch up now or later?
,Oct 1, 2:50 PM,
Phillip Von Gretener
,
Oct 1, 2:50 PM
,
Could we meet in 30m?
,Oct 1, 2:50 PM,
Oh, it's almost 5
,Oct 1, 2:50 PM,
Morning then?
,Oct 1, 2:51 PM,
You
,
Oct 1, 2:52 PM
,
Sure, tomorrow is fine. I am open in the morning until 10 AM EST.
,Oct 1, 2:52 PM,
Phillip Von Gretener
,
Oct 1, 2:52 PM
,
I'll grab some time

,Oct 1, 2:52 PM,
Monday, Oct 6
Phillip Von Gretener
,
Oct 6, 11:02 AM
,
Hi there. I'd love to get your feedback when you have a moment.
,Oct 6, 11:02 AM,
You
,
Oct 6, 12:30 PM
,
I am available now until the top of the hour.
,Oct 6, 12:30 PM,
Phillip Von Gretener
,
Oct 6, 12:31 PM
,
Give me 2m to finish this email
Video meeting
Google Meet
Join video meeting
,Oct 6, 12:31 PM,
joining
,Oct 6, 12:33 PM,
You
,
Oct 6, 12:33 PM
,
I'm on the call.
,Oct 6, 12:33 PM,
Phillip Von Gretener
,
Oct 6, 1:03 PM
,
do you have the demo invite?
,Oct 6, 1:03 PM,
I can't see the full list
,Oct 6, 1:04 PM,
You
,
Oct 6, 2:11 PM
,
I do not have this particular invite - I was in the candidate interview with Bradley for the BE role. 🙂
,Oct 6, 2:11 PM,
Phillip Von Gretener
,
Oct 6, 2:28 PM
,
oh, gotcha. Let me make sure you get added for the next one. I think these are important for you to be part of. It's owned by SEAA
,Oct 6, 2:28 PM,
Phillip Von Gretener
,
Oct 6, 2:41 PM
,
I just had a fascinating conversation with Elton
,Oct 6, 2:41 PM,
I have a 5:00 p.m., but I'm available for 15 minutes if you are
,Oct 6, 2:41 PM,
Tuesday, Oct 7
You
,
Oct 7, 7:26 AM
,
I have time now until the top of the hour. Daily stand up @ 10 AM EST
,Oct 7, 7:26 AM,
Phillip Von Gretener
,
Oct 7, 10:09 AM
,
Sorry. The morning very much got away from me. I wasn't expecting to have to go into the CFI headquarters for the data POC presentation today, and that hosed everything up. Let me see if I can get my arms back around the day, and maybe we could get together later if you have time.
,Oct 7, 10:09 AM,
You
,
Oct 7, 11:26 AM
,
Sure, let me know.
,Oct 7, 11:26 AM,
Phillip Von Gretener
,
Oct 7, 3:54 PM
,
Today was absolutely brutal. I was in Non-Stop meetings almost the entire day. This absolutely cannot continue, but that's my problem not yours. Unfortunately you and I do have a problem however that we need to solution. Do you have any availability tomorrow between 9:00 and 10:00 Eastern that we could talk?
,Oct 7, 3:54 PM,
You
,
Oct 7, 3:57 PM
,
Yes, I am available. Let’s do this! 🙂
,Oct 7, 3:57 PM,
Phillip Von Gretener
,
Oct 7, 3:57 PM
,
Appreciated. I'll drop some time on your schedule. I have quite a bombshell to drop on you. If you have 10 minutes now I could share it with you, but I would certainly understand if you would rather wait until tomorrow.
,Oct 7, 3:57 PM,
Phillip Von Gretener
,
Oct 7, 3:58 PM
,
Edited,
Here's an appetizer for you. I just got a call from the CIO at CFI informing me me that Robert Beasey approached them to let them know that Randstad is defrauding them.
,Oct 7, 3:58 PM,Edited,
You
,
Oct 7, 5:16 PM
,
Hi, just finished dinner with the fam…I am available now if you are still online.
,Oct 7, 5:16 PM,
Phillip Von Gretener
,
Oct 7, 5:17 PM
,
Unfortunately Robert has put me in the position of having to escalate this, since he made allegations about their being unethical Financial considerations involved with this situation. As a result, here is the note that I'm above to send.

I received an urgent call this evening from Pete Rau, CIO at CFI. A Solutions Architect on our team, Robert Beasy, contacted CFI directly (via Bill Ewald, a CFI leader supporting the K12 project) to allege that Randstad is engaged in deliberate defrauding related to a core element of the K12 platform design. Robert stated his belief that financial considerations and risk to profit were at the core of our approach (my term for his accusation). Robert's claim stems from his strong, aggressively vocal disagreement with a key architectural decision made late last year (use of data-driven architecture). While it has not yet been determined whether a serious problem with the design exists, we are being proactive in evaluating potential course correction. I must confirm that this design decision, though made on our advice, was collaboratively approved by CFI and SEAA, ensuring transparency. Furthermore, our team escalated concerns regarding the viability of this approach to Rob Hines (VP Product) and Pete within hours of the issue being raised last week, and Robert has been part of these ongoing discussions to evaluate refactoring and redesign options if required.

My immediate and primary concern is the unauthorized and damaging communication to the client executive level, which creates significant partnership risk. Robert noted to the client, "I’ll probably get fired for this, but I had to warn you." I should note that Robert never indicated to me that he felt our actions were unethical or inappropriate, making this external allegation entirely new information.

Pete was very clear that he believes we are handling this appropriately and stated he retains his complete trust in us. While he is reluctant to see a "whistleblower" dealt with harshly, he indicated he certainly understands that this breach of conduct and trust cannot be ignored.

Please let me know how you would like to proceed.

Phil
,Oct 7, 5:17 PM,
At this point, I'm too tired and drained to go into it tonight, but let's definitely talk in the morning. The grand irony is that I'm not really that dead set against taking decisive action on this, but we cannot do so in a vacuum. In the end, Robert might have one out to one degree or another. But that's moot at this point.
,Oct 7, 5:18 PM,
You
,
Oct 7, 5:22 PM
,
OK, we can approach this problem tomorrow with a fresh mindset. I’ll make whatever time is necessary for our conversation.
,Oct 7, 5:22 PM,
Phillip Von Gretener
,
Oct 7, 5:22 PM
,
Appreciated. Funny thing is I wanted to share with you that I had a good conversation with Pete this evening prior to that call that included his openness to the possibility of reevaluating the data-driven approach if needed. Let's talk more tomorrow. Have a nice evening.
,Oct 7, 5:22 PM,
Phillip Von Gretener
,
Oct 7, 5:30 PM
,
I made a small but important addition towards the end of that message that I think you should be aware of.

I received an urgent call this evening from Pete Rau, CIO at CFI. A Solutions Architect on our team, Robert Beasy, contacted CFI directly (via Bill Ewald, a CFI leader supporting the K12 project) to allege that Randstad is engaged in deliberate defrauding related to a core element of the K12 platform design. Robert stated his belief that financial considerations and risk to profit were at the core of our approach (my term for his accusation). Robert's claim stems from his strong, aggressively vocal disagreement with a key architectural decision made late last year (use of data-driven architecture). While it has not yet been determined whether a serious problem with the design exists, we are being proactive in evaluating potential course correction. I must confirm that this design decision, though made on our advice, was collaboratively approved by CFI and SEAA, ensuring transparency. Furthermore, our team escalated concerns regarding the viability of this approach to Rob Hines (VP Product) and Pete within hours of the issue being raised last week, and Robert has been part of these ongoing discussions to evaluate refactoring and redesign options if required.

My immediate and primary concern is the unauthorized and potentially damaging communication to the client executive level, which creates significant partnership risk. Robert noted to the client, "I’ll probably get fired for this, but I had to warn you." I should note that Robert never indicated to me that he felt our actions were unethical or inappropriate, making this external allegation entirely new information.

There is an additional risk that we need to consider. Robert already went straight to CFI with his unfounded concern, and when that proves to be ineffective he may decide to go to SEAA, or worse, social media or the press. SEAA is extremely sensitive about the possibility of any negative coverage in the press, and they have reinforced this with us repeatedly. I don't know how to approach that situation, but I wanted to draw it to your attention.

Pete was very clear that he believes we are handling this architecture discussion appropriately and stated he retains his complete trust in us. While he is reluctant to see a "whistleblower" dealt with harshly, he indicated he certainly understands that this breach of conduct and trust cannot be ignored.

Please let me know how you would like to proceed.

Phil
,Oct 7, 5:30 PM,
Wednesday, Oct 8
Phillip Von Gretener
,
Oct 8, 7:01 AM
,
I'll be there in just a sec. On with legal
,Oct 8, 7:01 AM,
Phillip Von Gretener
,
Oct 8, 7:06 AM
,
this is going to take a bit of time. now i have an SVP on the line. Let me push us out if that's okay
,Oct 8, 7:06 AM,
You
,
Oct 8, 7:22 AM
,
Sure thing. No problem.
,Oct 8, 7:22 AM,
Phillip Von Gretener
,
Oct 8, 7:29 AM
,
jumping on
,Oct 8, 7:29 AM,
Thursday, Oct 9
Phillip Von Gretener
,
Oct 9, 7:52 AM
,
For later, after this meeting: Both Terry and Angelo have expressed interest in being promoted into Robert's vacant role. My hunch is Terry could be a candidate, but that Angelo probably doesn't have the skill set. What are your thoughts? You may not have an opinion on Angelo, which is fine.
,Oct 9, 7:52 AM,
You
,
Oct 9, 8:34 AM
,
I think Terry has the mindset and techncial abilities. I have not worked with Angelo yet - I think some due-diligence interviews will provide the answer. Do we have any external candidates also?
,Oct 9, 8:34 AM,
Phillip Von Gretener
,
Oct 9, 9:09 AM
,
We will, yes. Probably as soon as tomorrow.
,Oct 9, 9:09 AM,
Tuesday, Oct 14
You
,
Oct 14, 5:41 PM
,
Let me know when you are back - I can provide you with the Director’s cut 🎬edition of the roadmap and EB decision.
,Oct 14, 5:41 PM,
Wednesday, Oct 15
Phillip Von Gretener
,
Oct 15, 5:32 AM
,
Good morning! I'm stepping back in lightly today. My goal is to review the 150+ unread emails and 40+ unread IM threads, ha! Please let me know when convenient to chat, and I'd love to hear about current events.
,Oct 15, 5:32 AM,
You
,
Oct 15, 10:16 AM
,
image.png
,Oct 15, 10:16 AM,
You
,
Oct 15, 10:41 AM
,
I will need a few minuites with you after this meeting - when you have a moment. Thanks.
,Oct 15, 10:41 AM,
Quoted
Sent by
You
I will need a few minuites with you after this meeting - when you have a moment. Thanks.
End Quote press L to link back to original quote
 take rest...we'll talk later.
,Oct 15, 10:42 AM,
Phillip Von Gretener
,
Oct 15, 10:56 AM
,
Sorry, I had a lot of messages queued up, and I just saw that you wanted to talk to me after the meeting. Why don't we go ahead and chat now, as I suspect I'm going to be out of action for a few hours.
,Oct 15, 10:56 AM,
Looks like you're away. I'm going to get something to drink and lay down. I'll check back in later.
,Oct 15, 10:57 AM,
You
,
Oct 15, 11:10 AM
,
Hope you feel better - I'll be here.
,Oct 15, 11:10 AM,
Phillip Von Gretener
,
Oct 15, 1:09 PM
,
Hello
,Oct 15, 1:09 PM,
Let's jump on when you have a moment
,Oct 15, 1:09 PM,
Phillip Von Gretener
,
Oct 15, 1:38 PM
,
Matt?
,Oct 15, 1:38 PM,
You
,
Oct 15, 3:41 PM
,
Yes, I am here. Typing notes from RDS meeting.. 🙂
,Oct 15, 3:41 PM,
Phillip Von Gretener
,
Oct 15, 3:43 PM
,
Okay, great. Let's talk.
,Oct 15, 3:43 PM,
You (via Meet)
,
Oct 15, 3:53 PM
,

Huddle ended
,Oct 15, 3:53 PM,
Thursday, Oct 16
Phillip Von Gretener (via Meet)
,
Oct 16, 6:08 AM
,

Huddle ended
,Oct 16, 6:08 AM,
Phillip Von Gretener (via Meet)
,
Oct 16, 6:09 AM
,

Huddle ended
,Oct 16, 6:09 AM,
Phillip Von Gretener
,
Oct 16, 6:33 AM
,
You should to plan to call me prior to logging on the call (that started half an hour ago).
,Oct 16, 6:33 AM,
Phillip Von Gretener
,
Oct 16, 7:05 AM
,
I understand you surfaced
,Oct 16, 7:05 AM,
You (via Meet)
,
Oct 16, 7:06 AM
,

Huddle ended
,Oct 16, 7:06 AM,
Phillip Von Gretener
,
Oct 16, 7:06 AM
,
I'll ring you in a moment.
,Oct 16, 7:06 AM,
I'm on a call
,Oct 16, 7:06 AM,
sit tight
,Oct 16, 7:06 AM,
Phillip Von Gretener
,
Oct 16, 7:12 AM
,
calling you now
,Oct 16, 7:12 AM,
Video meeting
Google Meet
Join video meeting
,Oct 16, 7:13 AM,
Monday, Oct 20
Phillip Von Gretener
,
Oct 20, 7:58 AM
,
Good morning. I'm more or less back up and running this week. The covid turned into pneumonia late last week, but they've had me loaded up with all the right medications since then, and as of this morning I feel pretty much human again. I wanted to coordinate with you on one topic in particular, and that is the replacement of architecture resources. My proposal is that (1) we add Terry as an applications architect to replace Robert, and (2) add Mario as an applications architect with a development coordination (CoP) focus as a net new role, and (3) I need you to let me know whether or not we need to replace Elton's capacity as a Enterprise Architect for the PAT team <or> we could just replace Terry's capacity as senior platform engineer.
,Oct 20, 7:58 AM,
And I know you've also been engaged in some interviews, so there could be opportunities there as well. But we're applicable I would rather promote from within.
,Oct 20, 7:58 AM,
You
,
Oct 20, 8:25 AM
,
Edited,
Sorry to hear about the pneumonia...ugh!  I have (2) interviews schedule for today. 

0900 MTN with Terry Fraser. I already agree that he would be a great replacement for Robert's role as Application Architect. In our discussions during the last few weeks, he has demonstrated many of the characteristics/attributes that we need here. I feel confident to move forward with Terry on this role.
1100 MTN with Mario. I have not worked with Mario much on this project. I would like to interview Mario to learn more about the FE/Architecture fit and his "architecture" experience.
,Oct 20, 8:25 AM,Edited,
Regarding the topic of Enterprise Architect | Platform Engineer...(thinking)
,Oct 20, 8:26 AM,
Phillip Von Gretener
,
Oct 20, 8:29 AM
,
Perfect, on all accounts. Let me know your decisions. Thanks.
,Oct 20, 8:29 AM,
You
,
Oct 20, 8:35 AM
,
I interviewed "Sreenivas Sadhanala" Friday afternoon. He is a good fit for our team for his Azure and Enterprise experience. He has some nice fit with technical and business logic (BE) for financial applications - our GL features are going to be a high-priority with higher risk than other parts of the app. Sreenivas is more of a combination between Platform and Enterprise (more here). This candidate has stood out from the previous (2) interviews. I would recommend Sreenivas Sadhanala as a replacement for Elton.

,Oct 20, 8:35 AM,
You
,
Oct 20, 8:45 AM
,
BTW: Chad Beard has an interview scheduled for tomorrow at 9 AM.

,Oct 20, 8:45 AM,
You
,
Oct 20, 1:57 PM
,
Terry: Terry interviewed quite well for the role. His background and thought-mentality provides a balance of getting our Core infrastructure established. 

Mario: I interviewed Mario this afternoon. His background on frontend and Angular in particular is very good. It absolutely makes sense to have Architecture alignment on the frontend applications. I have a short-list of items that need to be put on this FE Architecture roadmap. I think Mario is a front-runner for this FE-leaning architecture role.

Chad: Interview scheduled for tomorrow.
,Oct 20, 1:57 PM,
Phillip Von Gretener
,
Oct 20, 1:58 PM
,
Thank you for the update. That's really great news, and it's what I was hoping to hear. Let me know how Chad does. Thanks.
,Oct 20, 1:58 PM,
Tuesday, Oct 21
Phillip Von Gretener
,
Oct 21, 12:36 PM
,
Hi there. Could you please give me your feedback on the following? I would like to proceed with extending offers or assignments this afternoon. Thanks.

This is for reference only. I'm not trying to make your mind up for you. 

Applications Architect (Lead) - Matt Vaughn
Enterprise Architect (BE strength) - Terry Fraser    replaces Elton
Applications Architect (FE strength) - Mario Giambanco    replaces Robert
Applications Architect (Special Assignments) - Brandon Berry
Enterprise Platform Engineer - Replaces Terry - Do we need to staff this role?
,Oct 21, 12:36 PM,
You
,
Oct 21, 1:56 PM
,
I'm in the data meeting with the team - I'll update the feedback right after. Is that ok?

,Oct 21, 1:56 PM,
You
,
Oct 21, 3:15 PM
,
Edited,
Updating roster now.
,Oct 21, 3:15 PM,Edited,
You
,
Oct 21, 3:25 PM
,
Hi Phillip,
I interviewed Chad today - we had a nice discussion. He is very engaged in the project and certainly demonstrates leadership skills on his team. He helps his team with technical decisions and guidance. However, my opinion is that he is not quite ready for an architecture role.

I would like to figure out a way to utilize his experience more throughout our development teams. Regarding the PAT Roster - I am very comfortable with the following:

Applications Architect (Lead) - Matt Vaughn
Enterprise Architect (BE strength) - Terry Fraser    replaces Elton
Applications Architect (FE strength) - Mario Giambanco    replaces Robert
Applications Architect (Special Assignments) - Brandon Berry

Enterprise Platform Engineer: We might not require a Platform role, however, due to the number of integrations (some of them being very complex), we might need a resource to help get through the implementation(s) with a strong Azure and BE background. Could this be Brandon Berry after the Data Mapper/EB work?

Some of the integrations include:
RDS with our new K12 system as the determination of residency; integrate event workflow with K12
Class Wallet
Spark Post
Cisco Call Center
PID?
Workflow and Events for the Tasking Engine (automation)
,Oct 21, 3:25 PM,
Phillip Von Gretener
,
Oct 21, 3:31 PM
,
I think that makes sense, and I like the plan. Regarding Chad, what would you think of making a hybrid lead role that would be filled by both Chad and by the new guy who starts on Monday, Nick. In this role they would be still mostly assigned as development leads on their team, but they would also have specific responsibilities around Communications and community of practice for the developers. What would you think of that?
,Oct 21, 3:31 PM,
You
,
Oct 21, 4:08 PM
,
We definitely could use more of that! Champions for standards, practice, and developer focused. I think it’s a great idea. It also allows us to use Chad’s influence and energy.

,Oct 21, 4:08 PM,
Friday, Oct 24
Phillip Von Gretener
,
Oct 24, 8:41 AM
,
You are certainly welcome to join this meeting weekly, though I could also see a good argument to insulate you from it. This is a valueless readout we are required to do weekly.
,Oct 24, 8:41 AM,
Monday, Oct 27
You
,
Oct 27, 12:59 PM
,
Hi Phillip. 

I heard through the grapevine/comments that I there is going to be a new PAT PO.
,Oct 27, 12:59 PM,
Phillip Von Gretener
,
Oct 27, 1:03 PM
,
Edited,
Hi there. Yes, the product team is undergoing some reorganization to support current objectives and timelines, and they wanted to move one of their POs, Kim, from Cobra Kai to PAT, and another of their POs, Jacquelyn, from Eagle Fang to Cobra Kai. They are still working out the details, and I anticipate that they will be making an announcement tomorrow morning.
,Oct 27, 1:03 PM,Edited,
You
,
Oct 27, 1:09 PM
,
Interesting, what can I do to help?
,Oct 27, 1:09 PM,
Phillip Von Gretener
,
Oct 27, 1:11 PM
,
Well, I'm a little surprised that they apparently didn't involve you in their decision to make that change. Not that they're required to I suppose, since it's inside of their own team, but still, you're the tech leader... but I suppose the best thing you can do to help is work with Kim closely to ensure that she is able to come up to speed and begin providing value as soon as possible.
,Oct 27, 1:11 PM,
For my part I'm confident it was a good move. Kim will take a lot off of your shoulders, and enable you to focus where you can bring the most value. She will also dramatically tighten the linkage between PAT and product planning (Jacqui).
,Oct 27, 1:12 PM,
Tuesday, Oct 28
Phillip Von Gretener
,
Oct 28, 7:26 AM
,
I have a separate topic that I'd like to work with you on. As you know, Elton reached out to me several weeks back, and he explained that he didn't really have much to do, and now that we were moving away from our focus on microservices, he felt he would have nothing to do in the future. He recommended that he move on, and he asked me if I would give him 30 days. I agreed, and that 30 days is coming up in about a week and a half.
,Oct 28, 7:26 AM,
On Friday, he sent me the message below.
image.png
,Oct 28, 7:26 AM,
What I need from you is to understand what skill sets and allocations you require to accomplish the PAT team's scope. If you need both Terry and a second platform architect or engineer, then I'll make sure I get that for you. What I don't know is if you need someone as senior and expensive as Elton in addition to Terry. Could you give that some thought and let me know in the next two days? I need to let Elton know what his future looks like. As of now, my intention is to off-board him at the end of next week, but that's definitely open for discussion.
,Oct 28, 7:28 AM,
Please confirm so that I know that I can set this aside. Since it's time sensitive. Thanks.
,Oct 28, 7:28 AM,
You
,
Oct 28, 8:55 AM
,
Certainly, after some recent discussions with the architecture team, and Dev leads there is a need to establish our event–driven architecture soon.

Elton is working on items to support this. However, the progress has been slow and starting to raise questions even by Bill E. Elton is currently not supporting his work with Jira stories/details and proper estimations. 

We need the engine engineering experience. However, Elton is currently not acting as an architect at any level for our team today - and his participation is minimal. I would not trust his efforts as an independent engineer for this type of work.

Our BE and developer teams could use an engineer with expertise in event driven architectures with Azure
Azure Messaging (Event Grid, Service Bus)
Azure Logic Apps
perhaps Durable functions or other to support long-running workflows

I would like to propose that we began with the household application agreement workflow(document signature). This is a very simple use case and supports our integration with PandaDocs - a simple communication workflow with emails and notifications. It also involves database updates for application status. Something as simple as this could establish most of our event-driven architecture and be repeatable for several workflows and use cases.
,Oct 28, 8:55 AM,
Phillip Von Gretener
,
Oct 28, 9:28 AM
,
That sounds like a good plan. Would you like me to off-board Elton, and replace him with a back-end developer with the attributes described in your three bullets above? Is that what you are recommending?
,Oct 28, 9:28 AM,
You
,
Oct 28, 11:49 AM
,
Yes!
,Oct 28, 11:49 AM,
Phillip Von Gretener
,
Oct 28, 11:50 AM
,
Done. Elton's last day will be this Friday. Note - he does not yet know this, and I need to be the one to deliver that message, so please sit on that info for the moment.
,Oct 28, 11:50 AM,
You
,
Oct 28, 11:54 AM
,
OK, thanks Phillip.
,Oct 28, 11:54 AM,
Wednesday, Oct 29
Phillip Von Gretener
,
Oct 29, 10:16 AM
,
Would you please take a look at this, and please copy Katie, Rob, and me when you reach out to them. Thanks
image.png
,Oct 29, 10:16 AM,
You
,
Oct 29, 11:14 AM
,
Yes, certainly. This topic is on deck for discussion this Friday. I can reach out to the contact before this meeting and introduce myself.

,Oct 29, 11:14 AM,
Quoted

Sent by
Phillip Von Gretener

Would you please take a look at this, and please copy Katie, Rob, and me when you reach out to them. Thanks
End Quote press L to link back to original quote
I do like the "Mike" and the "or whoever" description. Funny. 😁
,Oct 29, 11:15 AM,
Phillip Von Gretener
,
Oct 29, 11:17 AM
,
Yah, ha!
,Oct 29, 11:17 AM,
You
,
Oct 29, 11:27 AM
,
I wish I had a dollar or two for each time I have been called Mike in my life...I could buy some Starbuck coffees ☕
,Oct 29, 11:27 AM,
Phillip Von Gretener
,
Oct 29, 11:27 AM
,
I get the exact same thing with "Peter". No clue why.
,Oct 29, 11:27 AM,
Friday, Oct 31
Phillip Von Gretener
,
Oct 31, 5:28 AM
,
Morning. Due to some red tape Elton will actually offboard next Friday. Just FYI.
,Oct 31, 5:28 AM,
You
,
Oct 31, 8:11 AM
,
Noted!
,Oct 31, 8:11 AM,
Tuesday, Nov 4
Phillip Von Gretener
,
Nov 4, 9:10 AM
,
Hi. I am going to work on the finances today and tomorrow, and I need to decide what I can afford to do, and if I need to work with CFI and SEAA executives to ask for more money. I need to know from you what additional roles you must have to ensure success. As I understand it currently, you need a BE engineer with Azure capabilities like Nick/Chad for the PAT team, and you need another Data Engineer like Ananda. Is that correct, and is that everything? Also, please know that I do not have budget for this, so while I am willing to go in front of the execs and get these resources, I want to make SURE this is a hard requirement. When I asked you yesterday you sounded a little uncertain. Please advise, and if 'yes' is the answer, please confirm my understanding of what you need.
,Nov 4, 9:10 AM,
You
,
Nov 4, 11:43 AM
,
Thinking here…. 🤔
,Nov 4, 11:43 AM,
You
,
Nov 4, 12:27 PM
,
My biggest concern today is the new database/schema for the new K12 system. The priority should be on the K12 database and establishing the foundation as early as possible. We might have an opportunity for the legacy data migration project to provide a simple/MVP migration of minimal data - this would have to be a strategic/surgical extraction/summarization of data elements to support the new K12 system. 

I would suggest at least 1, if not 2 data engineers to complete both projects above. With the amount of the event/workflow features we have to deliver, supplementing the developers with a dedicated BE engineer with Azure skills is a must. 

I feel like we still have not grasped the "workflow-oriented" development approach. I will continue to align with product this afternoon in this regard.
,Nov 4, 12:27 PM,
Wednesday, Nov 5
Phillip Von Gretener
,
Nov 5, 3:47 AM
,
Is the following correct? 
1) I will send you the boilerplate JD for a data engineer for your review, and I'll add 2 of them to my budget. 
2) I will plan to staff a BE engineer in Terry's old role (clone of Terry).

This puts us way over budget, so I need to be 100% sure you and I are aligned. I'm fine defending the overage, but I loathe the idea of doing so in error.
,Nov 5, 3:47 AM,
You
,
Nov 5, 8:04 AM
,
Yes, your understanding is correct. These roles are required to meet delivery timelines and ensure stability of the K12 platform. The additional data engineers are not optional—they’re necessary to deliver the database, schema, and data migration workstreams. The BE role fills the current capability gap in Azure-based event/workflow development.

,Nov 5, 8:04 AM,
Phillip Von Gretener
,
Nov 5, 8:39 AM
,
On it
,Nov 5, 8:39 AM,
Phillip Von Gretener
,
Nov 5, 11:15 AM
,
Do you want to interview the prospective full stack dev that is being considered for Mario's old role on Cobra Kai? Mario and Chad interviewed several people, and they have selected somebody they want to proceed with.
,Nov 5, 11:15 AM,
Phillip Von Gretener
,
Nov 5, 11:23 AM
,
Separately, for the data engineers, do I need people at Ananda's level or more junior?
,Nov 5, 11:23 AM,
You
,
Nov 5, 12:21 PM
,
I do not need to interview the FS dev. They might be capable as a junior to Ananda.
,Nov 5, 12:21 PM,
Phillip Von Gretener
,
Nov 5, 1:31 PM
,
Who would you like to have perform the interviews for the data Engineers? Ananda and...
,Nov 5, 1:31 PM,
You
,
Nov 5, 2:02 PM
,
I can be available - it would be nice to have a lead from one of the dev teams. Any suggestions?
,Nov 5, 2:02 PM,
Phillip Von Gretener
,
Nov 5, 2:04 PM
,
Probably Chad would be best.
,Nov 5, 2:04 PM,
You
,
Nov 5, 2:05 PM
,
That's who I was thinking about - great choice.

,Nov 5, 2:05 PM,
Message deleted by its author
,
Nov 5, 7:19 PM
Message deleted by its author
,
Nov 5, 7:19 PM
Thursday, Nov 6
Phillip Von Gretener
,
Nov 6, 7:07 AM
,
I know this isn't exactly what you were looking for, you were talking more about in-depth SME background, but when it just comes to who is in what role, don't forget that you have this resource. https://cfiorg.sharepoint.com/:p:/r/sites/K12Project/_layouts/15/Doc.aspx?sourcedoc=%7B6CBD32E0-8802-470F-ACC2-8539FC94EBA3%7D&file=K12%20Governance%20Model.pptx&action=edit&mobileredirect=true
,Nov 6, 7:07 AM,
Friday, Nov 7
Phillip Von Gretener
,
Nov 7, 8:45 AM
,
What version of copilot did you end up using? Enterprise?
,Nov 7, 8:45 AM,
You
,
Nov 7, 10:25 AM
,
I believe Enterprise is the only version/license that provides the AI security and “no sharing” of our information. 

Jill did some preliminary licensing cost - it is about $30/mo per developer.
,Nov 7, 10:25 AM,
Phillip Von Gretener
,
Nov 7, 11:31 AM
,
Ok. John will be reaching out to add all these components into the decision ticket. You're still approved to proceed, but we missed some of the steps in the approval process. Please give him your prompt support when he reaches out. It will help keep us from getting smacked for our miss and this one.
,Nov 7, 11:31 AM,
Phillip Von Gretener
,
Nov 11, 8:03 AM
,
I'm going to try to get this posted by midday today. If you get a chance, please give me your feedback. temp.pptx
,Nov 11, 8:03 AM,
Thursday, Nov 13
Phillip Von Gretener
,
Nov 13, 5:08 AM
,
Hi. Please be ready to present on Copilot in the weekly CFI leads meeting tomorrow. John added a comment to the ticket indicating the type of licenses that you expect, but for tomorrow they will need a precise number of licenses and monthly costing information.
,Nov 13, 5:08 AM,
You
,
Nov 13, 10:30 AM
,
Quoted

Sent by
Phillip Von Gretener
Hi. Please be ready to present on Copilot in the weekly CFI leads meeting tomorrow. John added a comment to the ticket indicating the type of licenses that you expect, but for tomorrow they will need a precise number of licenses and monthly costing information.
End Quote press L to link back to original quote
OK, I'll be ready.

,Nov 13, 10:30 AM,
You
,
Nov 13, 2:30 PM
,
I am prepared for the Copilot discussion tomorrow. I have the interview scheduled with a candidate at 11 AM EST - would I be able to go early in the meeting tomorrow (if not, it is OK. Terry can kick-off the interview).
,Nov 13, 2:30 PM,
Phillip Von Gretener
,
Nov 13, 3:11 PM
,
Absolutely! I'll have you go first.
,Nov 13, 3:11 PM,
You
,
Nov 13, 4:46 PM
,
Great, thanks!
,Nov 13, 4:46 PM,
Friday, Nov 14
Phillip Von Gretener
,
Nov 14, 7:59 AM
,
Here's the agenda for today. I added a PrimeNG topic just so we can make 100% sure we're aligned. Mind driving that topic? 

(MV) Matt will go first, as he has a conflict. Co-pilot licensing, costing, and overview
(MV) PrimeNG usage going forward. 
(PvG) Team incremental realignment updates
(LS) SonarQube - Note from last meeting: Luke will work with Stuart to work out the details, and he will get a meeting on the books. He will update the Decision ticket, and we can discuss this again in a future meeting.
(JI) Possibly talk about status on SOP ticket
(PC) Update on the maturity matrix, JDs, and re-org efforts?
(LS) ADO for Jira discussion (if it's ready for this week)
,Nov 14, 7:59 AM,
You
,
Nov 14, 8:15 AM
,
The interview got moved to 1 PM EST - I no longer have any schedule conflicts. 🙂
,Nov 14, 8:15 AM,
I'll put something together for the PrimeNG item also.

,Nov 14, 8:15 AM,
Phillip Von Gretener
,
Nov 14, 8:17 AM
,
Did anybody share with you the LinkedIn post that Thomas Franey made a couple weeks ago? It paints a really clear picture of his mindset.
,Nov 14, 8:17 AM,
53F7B3A0-3B39-4A7D-827E-DC2016E53BAE.png
,Nov 14, 8:17 AM,
I'm pretty sure he actually quiet-quit sometime last week, but things really came to a head yesterday.
,Nov 14, 8:18 AM,
Just FYI
,Nov 14, 8:18 AM,
Phillip Von Gretener
,
Nov 14, 8:58 AM
,
no
,Nov 14, 8:58 AM,
we've completed our eval
,Nov 14, 8:58 AM,
i'll take this
,Nov 14, 8:58 AM,
... ok
,Nov 14, 8:59 AM,
You
,
Nov 14, 9:31 AM
,
No, I did not see or hear about this post. I sensed frustration between him and other in a few meeting during the last few weeks - but nothing like this.
,Nov 14, 9:31 AM,
Whew! The PrimeNg topic hits a nerve with Sumith. Yikes.
,Nov 14, 9:32 AM,
Phillip Von Gretener
,
Nov 14, 9:39 AM
,
That's not the first time he's had a reaction like that to something, and In fairness, he's been no more difficult in these interactions than Brandon has. So I appreciate your cool head and excellent preparation.
,Nov 14, 9:39 AM,
Phillip Von Gretener
,
Nov 14, 9:44 AM
,
When you send that requirement over to Sumith, please be sure to copy Marty and Rob (and me) please. I want to make sure that having Sumith and his crew review this doesn't impact our critical path or prohibit us from being able to proceed. It should not act as a predecessor to the discussion I will set up with you, me, and Rob about the path forward.
,Nov 14, 9:44 AM,
You
,
Nov 14, 9:45 AM
,
Quoted

Sent by
Phillip Von Gretener
When you send that requirement over to Sumith, please be sure to copy Marty and Rob (and me) please. I want to make sure that having Sumith and his crew review this doesn't impact our critical path or prohibit us from being able to proceed. It should not act as a predecessor to the discussion I will set up with you, me, and Rob about the path forward.
End Quote press L to link back to original quote
Will do.
,Nov 14, 9:45 AM,
You
,
Nov 14, 2:18 PM
,
Quoted

Sent by
Phillip Von Gretener
I'm pretty sure he actually quiet-quit sometime last week, but things really came to a head yesterday.
End Quote press L to link back to original quote
Turning into a bad episode of the "The Office". He sent me a LI connect request to my Randstad email.
image.png
,Nov 14, 2:18 PM,
Phillip Von Gretener
,
Nov 14, 2:29 PM
,

,Nov 14, 2:29 PM,
Tuesday, Nov 18
Phillip Von Gretener
,
Nov 18, 10:46 AM
,
The PrimeNG gift just keeps giving. Following my conversation last night with Pete and Rob, Pete would like me to set up a brief and informal call with you, me, Marty, Pete and, Rob to talk about our use of this tool in slightly less contentious circumstances. I'll look for some time this afternoon or tomorrow on everyone's calendar. I just wanted to give you a heads up.
,Nov 18, 10:46 AM,
Phillip Von Gretener
,
Nov 18, 10:50 AM
,
It looks like 5:00 p.m. Eastern is the only time I could pull this whole group together. Please let me know if you can accommodate.
,Nov 18, 10:50 AM,
Phillip Von Gretener
,
Nov 18, 2:44 PM
,
You good?
,Nov 18, 2:44 PM,
Phillip Von Gretener
,
Nov 18, 2:48 PM
,
Because of some of the politics involved with this decision, I'm going to play Switzerland to the best of my ability. My goal is to ensure that their technical folks see that we have their best interest in mind, and your goal is to sell them on the best approach. Does that make sense?
,Nov 18, 2:48 PM,
You
,
Nov 18, 2:55 PM
,
Yep, all good
,Nov 18, 2:55 PM,
Phillip Von Gretener
,
Nov 18, 3:28 PM
,
Well done. Now let's pop some popcorn and see how this plays out.
,Nov 18, 3:28 PM,
You
,
Nov 18, 3:47 PM
,
Love it. I'll reach out to Mario and we can tag-team our discovery.

,Nov 18, 3:47 PM,
Thursday, Nov 20
Phillip Von Gretener
,
Nov 20, 11:11 AM
,
Were you able to find an applicable Material add-on that they could purchase that would effectively replace the need for PrimeNG without adding significant complexity or labor to our delivery process?
,Nov 20, 11:11 AM,
I need to remember to just message you directly on Teams...
,Nov 20, 11:12 AM,
You
,
Nov 20, 12:17 PM
,
We are not finding "material design" specific single-component packages for this use case. There are some/many online references on how to enable this feature on an existing Angular Material Design table component. So, there is some custom development to enhance our existing K12 Table (Material Design).
,Nov 20, 12:17 PM,
Phillip Von Gretener
,
Nov 20, 12:20 PM
,
Okay, that's more or less what I expected. We will most likely postpone this to PI6/7
,Nov 20, 12:20 PM,
Thanks
,Nov 20, 12:20 PM,
Phillip Von Gretener
,
Nov 20, 2:01 PM
,
Edited,
THANK YOU
,Nov 20, 2:01 PM,Edited,
Friday, Nov 21
You
,
Nov 21, 8:45 AM
,
We have a weekly DevSync meeting on Monday - I assume it is OK to let the devs know the decision of the (2) topics?
,Nov 21, 8:45 AM,
Phillip Von Gretener
,
Nov 21, 8:46 AM
,
100%
,Nov 21, 8:46 AM,
Monday, Dec 1
Phillip Von Gretener
,
Dec 1, 8:41 AM
,
Morning. I'm open between 11:30 EDT and 1:30, and I'd like to find a few minutes for us to chat ahead of the Data Mapper demo. I heard that you guys talked last week, and that you felt that the work they are doing is not being adequately governed by you. I assumed (reasonably I think) that all of this was being covered thoroughly in the PAT calls, but now I learn that maybe not. This is distressing to me. You are the leader in any technical matters (not Brandon or Jill or Phillip...), and if the team isn't involving you and getting your approval of their approach then that's a huge fail. I'd like to have that convo with you prior to the demo call, so we can focus on the tech in the demo, and not the process. Got 15m you can give me?
,Dec 1, 8:41 AM,
You
,
Dec 1, 8:55 AM
,
Certainly - can we chat at 11:30 EDT? We have our PAT Breakout (p4) starting at this time. I will let Victor know I will be a few minutes late.

,Dec 1, 8:55 AM,
Phillip Von Gretener
,
Dec 1, 8:59 AM
,
I'll ring you
,Dec 1, 8:59 AM,
Phillip Von Gretener
,
Dec 1, 9:35 AM
,
Sorry..... I got heads down putting out fires, and I just realized I missed our time. Are you still free?
,Dec 1, 9:35 AM,
You
,
Dec 1, 9:35 AM
,
Yes
,Dec 1, 9:35 AM,
Phillip Von Gretener
,
Dec 1, 9:35 AM
,
ring rinb
,Dec 1, 9:35 AM,
Video meeting
Google Meet
Join video meeting
,Dec 1, 9:35 AM,
Phillip Von Gretener
,
Dec 1, 11:38 AM
,
My questions to you, distilled down to the bare bones, will be 1) is this technically sound, and 2) is it a good use of Brandon's time.
,Dec 1, 11:38 AM,
You
,
Dec 1, 1:48 PM
,
I can provide my initial thought. 

data integrity is an issue (risk)because there is no validation or verification of the inputs before the direct insert into the database.
Developer experience: it requires an intimate knowledge of the database schemas; PK & FK references; custom tools require custom maintenance and ongoing support.
Legacy data migration: a potential limited use case here. There might not be a use for this tool after legacy data migration
Questions: I need more information, if it handles more complex data scenarios like derived values. 

My initial opinion is that there are most likely better tools to get legacy data into our core K-12 database. I get the sense that Ananda may not have a partial solution implemented yet as an alternative. Ananda has Azure data factory that can move the data into our core database tables without anything in between. I think the technical deep dive might provide more details here. My main concern is complexity and time to deliver a production bulletproof migration system.

From previous discussions, Brandon was targeted to complete the class wallet integration. The RDS integration is also a good candidate project for Brandon.
,Dec 1, 1:48 PM,
Tuesday, Dec 2
Phillip Von Gretener
,
Dec 2, 4:35 AM
,
Thank you, that is helpful. I've broken down your responses with Jill & Phillip, and they are tasked with coordinating with you to come to a firm resolution on this.
,Dec 2, 4:35 AM,
You
,
Dec 2, 8:26 AM
,
Good morning. Can we get an agenda item added to the CFI Friday weekly for a status update on the AI/Copilot "plan" decision. They were investigating the "non-profit" pricing if available.

,Dec 2, 8:26 AM,
You
,
Dec 2, 10:33 AM
,
Interesting chat about considering Cursor...

See: https://cfi-nc.atlassian.net/wiki/spaces/KR/pages/4510744587/Comparison+Summary+GitHub+Copilot+vs.+Cursor

Looking at the bigger picture and considering our client and security requirements: The obvious choice is Copilot. These were outlined in the proposal discussion. The assurance and security policies provided via the Copilot organization license are key.
,Dec 2, 10:33 AM,
image.png
,Dec 2, 10:34 AM,
Phillip Von Gretener
,
Dec 2, 10:38 AM
,
I'm glad you guys had the discussion, but I definitely agree that there is no real choice here -- unless cursor was something that could be used in addition to co-pilot. I'm not sure I see the use case as it stands.
,Dec 2, 10:38 AM,
Wednesday, Dec 3
Phillip Von Gretener
,
Dec 3, 7:17 AM
,
Morning. I just dropped a meeting on your calendar for tomorrow morning in which we will put-to-bed the concerns about the foundation work not being represented in the Product's planning. Please set your alarm and come ready to do battle! If you would like to take any time today to discuss what I'm looking for in that meeting I'm happy to jump on with you.
,Dec 3, 7:17 AM,
Coming out of this meeting, Jacqui/Jill will be ready to build out the full critical path of the foundational work that has not been adequately represented to date, and we will have one comprehensive plan that you and I can get behind.
,Dec 3, 7:18 AM,
Friday, Dec 5
Phillip Von Gretener
,
Dec 5, 8:20 AM
,
Hi. I'm very tardy this time I'm putting together my agenda for the leads meeting. It's been an insane week. In doing so, I realized that you aren't on the invitation. Are you available at 10:30 to come and discuss the co-pilot topic that you mentioned earlier in the week? I will forward you the invitation now, but please let me know whether or not you're able to attend.
,Dec 5, 8:20 AM,
You
,
Dec 5, 8:27 AM
,
Yes
,Dec 5, 8:27 AM,
Phillip Von Gretener
,
Dec 5, 8:29 AM
,
great
,Dec 5, 8:29 AM,
Monday, Dec 15
You
,
Dec 15, 9:39 AM
,
Hi - I am updating the Github Copilot cost based on recommended plan/subscriptions. Do you have an updated Team chart? I currently show a count of 24 potential users of Copilot (i.e., devs, QA, and DevOps).
,Dec 15, 9:39 AM,
Updated cost estimate at: https://cfi-nc.atlassian.net/wiki/spaces/KR/pages/4452352099/Copilot+Enterprise#A.-Fixed-Per-User-Costs-(Total-Users%3A-24)
,Dec 15, 9:40 AM,
Phillip Von Gretener
,
Dec 15, 9:48 AM
,
Thanks, and yes, you can use the one on Confluence. It's fully updated.
,Dec 15, 9:48 AM,
Wednesday, Dec 17
Phillip Von Gretener
,
Dec 17, 6:35 AM
,
Are you joining this call?
,Dec 17, 6:35 AM,
to be specific, are you joining this CLIENT FACING call that you are late for?
,Dec 17, 6:36 AM,
Phillip Von Gretener
,
Dec 17, 6:41 AM
,
You and I need to have a conversation about this. I'll schedule time. This is becoming an issue.
,Dec 17, 6:41 AM,
You
,
Dec 17, 7:37 AM
,
This was canceled yesterday and removed my calendar.
image.png
,Dec 17, 7:37 AM,
Phillip Von Gretener
,
Dec 17, 7:46 AM
,
i can't speak to that, but i'll take your word for it. you still appear on the invitation.
image.png
,Dec 17, 7:46 AM,
but if this was a microsoft issue then i certainly can't hold you responsible for it.
,Dec 17, 7:46 AM,
Phillip Von Gretener
,
Dec 17, 7:54 AM
,
since you have not been able to participate in either of the meetings on the topic, please reach out asap to jill and get a download on the tool sets that we have been evaluating between. i want to make sure that this has your seal of approval prior to proceeding, though at this point it may be too late for much value to be added.
,Dec 17, 7:54 AM,
please let me know once you have done so, so that i know that it has had your review.
,Dec 17, 7:54 AM,
You
,
Dec 17, 8:03 AM
,
I will reach out after our daily standup.
,Dec 17, 8:03 AM,
Phillip Von Gretener
,
Dec 17, 8:03 AM
,
great, thanks
,Dec 17, 8:03 AM,
You
,
Dec 17, 10:47 AM
,
Jill and I synced on the query builder tools. Metabase Pro is most likely our target based on client requirements and tool capabilities.

We also provided updates on workflow strategies for the team.
,Dec 17, 10:47 AM,
Phillip Von Gretener
,
Dec 17, 10:48 AM
,
Great, thanks. I'll proceed with that then.
,Dec 17, 10:48 AM,
Thursday, Dec 18
Phillip Von Gretener
,
Dec 18, 9:48 AM
,
What's your level of comfort on all of this? Is it adequately taking into consideration the foundation requirements?
,Dec 18, 9:48 AM,
You
,
Dec 18, 9:56 AM
,
I think we are light on the details. The "workflow" definitions are still a large work in progress. The teams are struggling with data, data seeding issues (which is a symptom of not having the foundational items in place). We are putting in the "workflow orchestration (enabler)" now (previous/current sprints); this should have been done a year ago. We are driving this as hard as we can as a PAT team.

Logical sequence of operations would be good/better for feature execution. However, the constraint is moving work to later PIs due to the availability/need according to the school calendar.
,Dec 18, 9:56 AM,
Phillip Von Gretener
,
Dec 18, 9:59 AM
,
Edited,
Understood. Do you feel we are on track to resolve this as a risk?   -------  never mind, you're responding to this in real time. thanks.
,Dec 18, 9:59 AM,Edited,
Monday, Dec 22
Phillip Von Gretener
,
Dec 22, 12:10 PM
,
Hi there. I had to move my family plans around today to make it possible to be at the call that you didn't show up for. I did so specifically to support you and the team.
,Dec 22, 12:10 PM,
I'm going back to my day off...
,Dec 22, 12:10 PM,
You
,
Dec 22, 12:17 PM
,
Hi Philip. I have no invites on my Google or teams calendar for our meeting this afternoon. I did ask Jill if she was planning on having one because it was mentioned in an email.
,Dec 22, 12:17 PM,
Phillip Von Gretener
,
Dec 22, 12:20 PM
,
That's interesting. It shows up as declined for her. I think you guys should touch base on that. It worked for everyone else, and we were there.
Message read by Phillip Von Gretener

,Dec 22, 12:20 PM,



In a meeting until 3:30 PM
Message Phillip Von Gretener

