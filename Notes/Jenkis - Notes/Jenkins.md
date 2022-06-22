# Jenkins

Tue, Jun 21, 2022 1:12 PM

Building Applications with Fresstyle Projects

Anatomy of the build

Source --> Git Repo

Workspace Folder --> Compiling, Automated Tests, Package the application, Clean artifacts of the previous build if there where additional changes to the application.

General
When clicking on Jenking Freestyle Project these are the settings that you can specify.
-Discard old builds
-GitHub Project
-This build requires lockable resources
\- This project is parameterized
\- Throttle Builds
-Disable this project
\- Execute current builds if necessary

Source Code Management
-None
-Git
    -Repository URL
    -Credentials
\- Branches to build
\- Repository Browser
\- Additional Behaviors

Build Triggers
\- Trigger builds remotely \(Scripts\)
\- Build after other projects are built
\- Build periodically
\- Github Hook Triggers for GITSCM polling
\- Poll SCM

Build Environment
\- Delete workspace before build starts
-Use secret text / file
\- Abort the build if it is stuck
\- Add timestamps to the console for the output
\- inspect build log for published gradle build scans
\- With Ant

Build
-add build step
\*\* When learning Jenkins, making sure the automation of the build iteslf work first and then using Jenkns is the best way to go about this.

Post-Build Actions
\- Add Post build actions