# Unix Practical – Change the Hostname in Linux

## Aim

To change the hostname in a Linux system using the hostnamectl command.

---

## Algorithm

Step 1: Start the virtual machine.

Step 2: Login to the terminal.

Step 3: Check the current hostname.

Step 4: Change the hostname using hostnamectl command.

Step 5: Execute a new Bash shell that immediately reflects the hostname change.

Step 6: Verify that the new hostname is displayed.

---

## Commands

The following commands are required:

hostnamectl

hostnamectl set-hostname rvs

exec bash

---

## Student Task

Complete the file:

hostname.sh

Your program must:

1. Check the current hostname.
2. Change the hostname to rvs.
3. Execute a new Bash shell using exec bash.

---

## Expected Program

The completed program should contain commands equivalent to:

hostnamectl

hostnamectl set-hostname rvs

exec bash

---

## How to Test in Linux

Open your Linux terminal and execute:

hostnamectl

Then:

sudo hostnamectl set-hostname rvs

Then:

exec bash

Finally:

hostnamectl

The hostname should display:

rvs

---

## GitHub Submission

1. Complete hostname.sh.
2. Save the file.
3. Commit the changes.
4. Push the changes to GitHub.
5. GitHub Actions will automatically execute the autograder.
6. Open the Actions tab to see the result.

---

## Marks

Total: 10 Marks

| Test | Marks |
|------|------:|
| Check current hostname | 2 |
| Use hostnamectl | 2 |
| Change hostname to rvs | 3 |
| Use exec bash | 2 |
| Program execution | 1 |
| Total | 10 |

---

## Result

The GitHub Actions result should show:

PASS

when all test cases are successfully completed.
