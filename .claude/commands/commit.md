---
description: Commit staged/relevant changes and push to the current branch's remote
---

When the user runs this command, it means "git commit and push" for the current state of the repo. Invoking it is itself the explicit per-action confirmation the project's git safety rules require for committing and pushing — no need to ask again before doing either.

Follow the standard commit workflow already described in your system instructions (check `git status`/`git diff`/`git log` in parallel, draft a message focused on *why*, stage specific files rather than `-A`, watch for anything that looks like a secret, commit with the `Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>` trailer), then:

1. Push the current branch to `origin` (`git push`, or `git push -u origin <branch>` if it isn't tracking a remote yet).
2. Never force-push.
3. If there's nothing to commit (clean tree), say so — don't invent an empty commit, and don't push if there's nothing new to push either.
