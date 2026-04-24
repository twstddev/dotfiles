---
name: writing-style
description: Use when the user invokes /writing-style to review writing style and grammar in technical documents. Reviews 2-3 paragraphs at a time for Plain English, British English grammar, and AI writing patterns, presenting corrections with explanations for the author to act on.
---

# Writing Style Review

## Invocation

```
/writing-style          # Review full document chunk by chunk
/writing-style [text]   # Review a specific passage directly
```

Can be run standalone or after `/writing-structure`.

---

## Before Starting

If the document type isn't clear, ask:
- "Is this a technical document with domain-specific terminology I should preserve?"

Identify domain vocabulary in the first pass (e.g., "idempotent", "microservices", "ETL pipeline") and do not flag these as Plain English violations. Flag only non-technical language that violates the guidelines.

---

## Review Standards

Apply all three in every chunk, in parallel. Present corrections ordered by their position in the text, not by category.

### 1. Plain English (Oxford Guide to Plain English — Martin Cutts)

- **Short words over long.** "use" not "utilise", "start" not "commence", "help" not "facilitate"
- **Active voice.** "The team decided" not "A decision was made by the team"
- **Short sentences.** Target average 15–20 words. Flag sentences over 30 words
- **No nominalisations.** "decide" not "make a decision", "analyse" not "conduct an analysis of"
- **No throat-clearing.** Cut "It should be noted that", "It is worth mentioning that", "It is important to note that"
- **Subject leads.** Avoid "There is/are", "There exists", "It can be seen that"
- **No redundant phrases.** "now" not "at this point in time", "because" not "due to the fact that", "if" not "in the event that"
- **Direct address.** Prefer "you" and "we" where appropriate; avoid impersonal constructions that distance the reader
- **Concrete over abstract.** Prefer specific, tangible language; flag vague abstractions

### 2. British English Grammar

- **Spelling:** -ise not -ize (organise, recognise), -our not -or (colour, behaviour), -re not -er (centre, theatre), -ogue not -og (catalogue), -ence not -ense (licence as noun, defence)
- **Verb/noun pairs:** practise (verb) / practice (noun); licence (noun) / license (verb)
- **Collective nouns take plural verbs:** "the team are", "the committee have decided"
- **Quotation marks:** single quotes primary ('like this'), double inside ('he said "hello"')
- **Different from**, not "different than"
- **Shall** for first person future (I/we shall)
- **Whilst** is acceptable alongside "while"
- **Programme** (general), **program** (computing only)
- **Oxford comma** is optional in British English — flag only for ambiguity, not absence

### 3. AI Writing Pattern Guardrails

Flag and correct any of the following:

**Vocabulary tells** — replace with plain alternatives:
- delve, delve into → explore, examine, look at
- showcase → show, demonstrate
- leverage (as verb) → use, apply, build on
- pivotal, paramount, crucial → important, key, critical (and only when genuinely warranted)
- multifaceted, intricate, meticulous → specific description of what makes it complex
- realm, tapestry, beacon, landscape → cut or replace with the concrete thing being described
- noteworthy, commendable → state what is notable and why, don't editoralise
- commence → start
- underscores, highlights (used to attribute agency to a document) → the document shows / this means
- robust, seamless, cutting-edge → replace with what specifically is strong, smooth, or advanced

**Structural tells:**
- Overuse of the rule of three (A, B, and C) — vary list lengths
- Bullet points for everything — use prose when building an argument or narrative
- Treadmill effect: same idea restated across multiple sentences — cut to one clear statement
- Heavy em dash use — more than one or two per page is a tell; use sparingly

**Transition tells** — flag hollow connectives:
- "Furthermore", "Moreover", "Additionally" at sentence starts — cut or use "Also" / restructure
- "In conclusion", "To summarise" — cut; let the conclusion speak for itself
- "It is worth noting that", "Notably" — cut the opener; just state the point
- "Having said that", "That being said" — cut; use "But" or restructure

**Phrasing tells:**
- "but here's the thing", "here's what matters", "here's the truth" — cut; state the point directly
- "In today's world", "In the modern era" — cut; context is usually obvious
- "This is not just about X, it's about Y" — restructure into a direct claim

---

## Chunk Processing

1. Take the first 2–3 paragraphs. If a chunk has more than 6 corrections, process only 2 paragraphs and note this before the next chunk.
2. Review all three standards in parallel.
3. Present corrections ordered by position in the text.
4. After each chunk, pause and ask: **"Ready for the next section?"**

---

## Correction Format

For each issue:

> **Original:** "[exact quote from text]"
> **Corrected:** "[revised version]"
> *[One sentence explaining the rule and why the correction improves the text.]*

Tag the issue type in italics at the start of the explanation: *(Plain English)*, *(British English)*, or *(AI tell)*.

Group corrections by paragraph with a heading:

```
### Paragraph 1

[Correction A]
[Correction B]

### Paragraph 2

[Correction C]
```

---

## Pattern Tracking

Track recurring issues silently throughout the review. At the end of the full document, present a summary:

```
## Recurring Patterns

These issues appeared consistently across the document:

- [Pattern]: appeared [N] times. [One sentence on how to avoid it going forward.]
- ...
```

Only include patterns that appear 3 or more times.

---

## Default Mode: Feedback Only

Do not rewrite or restructure the document unless explicitly asked. If asked for edits, apply only the corrections already flagged — do not make unrequested changes elsewhere.
