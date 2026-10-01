---
name: handoff-new-chat
description: Handoff to a new chat in this project.
argument-hint: "What will the new chat session be used for?"
disable-model-invocation: true
---

Write a compact, concise handoff summarizing the current conversation to continue the current work. Create a new Codex non-worktree chat inside the current project using the same model and reasoning effort settings as current and give it the handoff as the initial message.

Do not fork the current chat and do not create or save a handoff file unless explicitly requested. Return the handoff directly in the response.

Do not duplicate content already captured in other artifacts (specs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead.

If the user passed arguments, treat them as the intended name or focus of the new chat and tailor the handoff accordingly.
