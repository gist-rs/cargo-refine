# Refine (`cargo-refine`) — End User License Agreement

Version 1 · effective 2026-10-03

This agreement is between you and Todsaporn Banjerdkit ("we", "us"), the author of
Refine. It covers the `cargo-refine` program as released in binary form
(the "Software"), and your use of the Refine network services it connects to
(the "Service").

By installing, copying or running the Software, you agree to these terms. If you
do not agree, do not install or run it. If you accept on behalf of an
organisation, you confirm you may bind it, and "you" means that organisation.

## 1. Which releases these terms cover

These terms cover every release of the Software published on or after the
effective date above. Copies of releases published before that date (v0.2.0 and
earlier) remain under the notice they shipped with. Those copies are not
re-licensed by this agreement, and nothing here takes away a right those
notices already gave you.

## 2. What you may do

We grant you a free, worldwide, non-exclusive, non-transferable licence to:

- install and run the Software on any number of machines you own or control,
  including CI runners and containers;
- use it on your own code and code you are authorised to change, for personal
  or commercial work;
- keep internal copies, for example in an internal cache or artifact store,
  for those uses.

You can share the Software with others by pointing them at our official
release page or installers, so that they get it from us under these terms.

## 3. What you may not do

You may not, and may not help anyone else to:

1. sell, rent, lease, sublicense or publicly redistribute the Software, or
   ship it inside another product, without our written permission;
2. modify the Software, or decompile, disassemble or reverse engineer it,
   except to the extent that applicable law allows this despite this
   restriction;
3. remove or alter any licence, copyright or attribution notice;
4. bypass, disable or tamper with metering, billing, account limits, rule-set
   signatures, update checks or any other control in the Software or the
   Service;
5. send the Service false data, including fabricated contribution records,
   forged signatures or replayed batches, or try to get credits you have not
   earned;
6. use the Service in a way that harms it or other users: overloading it,
   scraping it in bulk, probing it for vulnerabilities without our permission,
   or accessing accounts that are not yours;
7. use the Software, the Service or the rule sets they deliver to build or
   train a competing code-fixing product or rule-set service;
8. use the Software in breach of any law that applies to you, including export
   control and sanctions law.

We keep every right not expressly granted here. The Software is licensed to you,
not sold.

## 4. Your code stays yours

We claim no ownership of your code, or of the changes the Software makes to it.
The Software only changes files on your machine. Review its changes before you
commit them, and keep your work under version control.

## 5. Network use and your data

The Software contacts the Service to check for rule-set updates and, depending on
the options you choose, to meter usage, sync account state, report statistics,
or send contributions. What is sent in each mode is listed in the "What leaves
your machine" section of the public README at
<https://github.com/gist-rs/cargo-refine#what-leaves-your-machine>. That section
is part of this agreement. You can turn off update checks with
`--no-update`. Statistics and mining are off until you turn them on.

We use the data we receive to run, secure, bill, improve and debug the Service.
We do not sell it.

## 6. Contributions (mining)

If you turn on mining (`--mine`), the Software sends us records of fixes it made,
which can include short code snippets as described in the README ("your
Contributions").

- You confirm that you have the right to share each Contribution with us, and
  that sharing it does not breach any duty of confidentiality or any other
  agreement you are bound by. Only mine repositories you are allowed to share
  code from.
- You grant us a worldwide, perpetual, irrevocable, royalty-free,
  non-exclusive licence to use, copy, store, analyse, modify, combine with
  other data, and incorporate your Contributions into rule sets, models and the
  Service. You also grant us the right to distribute rule sets derived from
  them. This licence continues after you stop mining or this agreement ends.
- The Software scans snippets for secrets and drops any snippet with a finding,
  but no scanner is perfect. **You are responsible for what is in the code you
  choose to mine.** Turn mining off for repositories that contain secrets or
  confidential material.
- `--unmine` stops future Contributions. It does not withdraw Contributions
  already sent, or rule sets already built from them.

## 7. KAT credits

KAT is the Service's internal credit. It is not money, a security, a deposit, a
token you own, or a claim against us.

- KAT has no cash value, and cannot be redeemed, refunded or exchanged with us
  for money.
- KAT can be moved only in the ways the Service itself provides.
- We set and may change how KAT is earned, charged and settled, including
  rates, pool sizes and epoch rules.
- We may correct balances changed by error, and may suspend, adjust or cancel
  KAT obtained through fraud, abuse, bugs, or a breach of these terms.
- We may discontinue KAT, and the Service, at any time. If the Service ends, any
  unused KAT ends with it.

## 8. Accounts

Your account key is stored on your machine (by default in `~/.config/riir-auth/`).
Keep it secret: anyone holding it can act as you on the Service. We are not
responsible for losses caused by a key you exposed, lost or shared.

## 9. Third-party components

The Software includes open-source components. Each release archive includes
`THIRD_PARTY_LICENSES.md`, which lists them with their licence texts. Those
licences govern those components, and where they conflict with this agreement
for a component, they win for that component.

## 10. Updates and changes to these terms

We may release new versions of the Software and change or stop the Service. A new
version may come with a new version of this agreement. That version applies to
the release it ships with, and to your use of the Service from when you start
using that release. A copy you already have stays under the terms it shipped
with.

## 11. Ending this agreement

You can end this agreement at any time by deleting every copy of the Software.
It ends automatically if you breach it. We may suspend or close your Service
access if you breach it or put the Service or other users at risk. When it ends,
you must stop using the Software and delete your copies. Sections 4, 6, 7 and
11–16 continue after it ends.

## 12. No warranty

THE SOFTWARE AND THE SERVICE ARE PROVIDED "AS IS" AND "AS AVAILABLE", WITHOUT
WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING ANY WARRANTY OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, NON-INFRINGEMENT,
ACCURACY, OR UNINTERRUPTED OR ERROR-FREE OPERATION. AUTOMATED FIXES CAN BE WRONG,
CAN CHANGE BEHAVIOUR, AND CAN BREAK CODE THAT COMPILED BEFORE. YOU ARE
RESPONSIBLE FOR REVIEWING, TESTING AND BACKING UP YOUR CODE.

## 13. Limitation of liability

TO THE MAXIMUM EXTENT ALLOWED BY LAW:

- WE ARE NOT LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL,
  EXEMPLARY OR PUNITIVE DAMAGES, OR FOR LOST PROFITS, REVENUE, DATA, CODE,
  GOODWILL OR BUSINESS INTERRUPTION, HOWEVER CAUSED, EVEN IF WE WERE TOLD THEY
  WERE POSSIBLE;
- OUR TOTAL LIABILITY FOR ALL CLAIMS ABOUT THE SOFTWARE, THE SERVICE, KAT OR
  THIS AGREEMENT IS LIMITED TO THE GREATER OF (A) THE AMOUNT YOU PAID US IN
  MONEY FOR THE SERVICE IN THE 12 MONTHS BEFORE THE CLAIM AROSE, AND (B) 50 US
  DOLLARS.

Some laws do not allow some of these exclusions or limits. Where that is so,
they apply only as far as that law allows.

## 14. Your responsibility to us

You will defend and compensate us against third-party claims, and the losses
and reasonable costs that follow from them, that arise from (a) your
Contributions, including a claim that sharing them breached someone's rights or
a confidentiality duty, or (b) your breach of section 3.

## 15. General

- This is the whole agreement between you and us about the Software. The README,
  where this agreement refers to it, is part of it.
- If any part is found unenforceable, it is enforced as far as it can be and the
  rest still applies.
- Not enforcing a term straight away does not waive it.
- You may not transfer this agreement without our written consent. We may
  transfer it to a successor of the Software or the Service.

## 16. Contact

Questions about these terms: open an issue at
<https://github.com/gist-rs/cargo-refine/issues>.
