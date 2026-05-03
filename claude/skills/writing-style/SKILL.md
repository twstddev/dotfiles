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

## Voice Identification (do this before the first chunk)

Read the opening two paragraphs without flagging anything. Map the author's voice:

- **Register:** Formal and precise? Conversational and direct? Somewhere in between?
- **Sentence rhythm:** Does the author favour longer, flowing sentences or short, punchy ones?
- **Vocabulary level:** Do they use elevated vocabulary intentionally, or does it feel like filler?
- **Personality markers:** Dry wit? Hedged and careful? Assertive?

State the voice profile briefly before starting the first chunk:
> *"Voice: [one sentence description]. Calibrating corrections to preserve this."*

Apply this profile throughout. Plain English corrections should improve clarity without flattening the author's register. If a correction would make the writing sound like it came from a different person, offer it as a suggestion with a note — do not present it as a required fix.

**Hard rules (always correct regardless of voice):**
- British English spelling and grammar
- AI writing tells
- Throat-clearing openers with no informational value
- Nominalisations that add no nuance

**Voice-sensitive (adapt to author's register):**
- Sentence length — flag only genuine run-ons, not stylistic long sentences
- Word choice — suggest shorter alternatives only when the longer word adds no precision
- Active vs. passive — flag passive when it obscures accountability; leave it when the author uses it for deliberate rhythm or emphasis

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

1. Number every paragraph in the document before starting (mentally or explicitly). Track which have been reviewed.
2. Take the next 2–3 unreviewed paragraphs. If a chunk has more than 6 corrections, use only 2 paragraphs for that chunk.
3. Review all three standards in parallel, calibrated against the author's voice profile.
4. Present all corrections for the chunk as an overview (see Correction Format), ordered by position in the text.
5. State which paragraphs were covered and how many remain:
   > *"Covered paragraphs 4–6. [N] paragraphs remaining."*
6. Immediately present each correction from the chunk as an edit suggestion, one by one (see Edit Mode below). Do not wait to be asked.
7. When all edits for the chunk are resolved or the author says "next chunk", move to the next unreviewed paragraphs.
8. Never re-review or skip paragraphs. Short paragraphs, transitional sentences, and final paragraphs of a section all count and must be included.
9. When all paragraphs have been covered, say so explicitly before presenting the pattern summary.

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

## Edit Mode

Edit Mode runs automatically after each chunk's feedback overview. Do not wait to be asked — present the first suggestion immediately after the overview.

### Per-chunk edit queue

Use the corrections already presented in the chunk overview, in the same order (by position in text). Do not introduce new corrections in edit mode.

### Presenting each suggestion

Show one suggestion at a time:

```
Suggestion [N of total for this chunk] · [Paragraph N] · (Plain English / British English / AI tell)

CONTEXT
[One sentence of surrounding text before the affected passage, if available.]

ORIGINAL
"[Exact quoted text]"

SUGGESTED
"[Replacement text]"

[One sentence of surrounding text after the affected passage, if available.]

WHY
[One sentence: the rule this applies and what it improves.]
```

Wait for the author's response before showing the next suggestion.

### Author responses

- **Accept** — log as accepted, show next suggestion
- **Skip** — log as skipped, show next suggestion
- **Modify: [their version]** — log their version as accepted, show next suggestion
- **Next chunk** — stop edits for this chunk, move to the next paragraphs
- **Stop** — end the session, show the session summary

### Status line

After every decision, show a one-line status:
> *[N] accepted · [N] skipped · [N] remaining this chunk*

### End of each chunk's edits

When all suggestions for a chunk are exhausted or the author says "next chunk":

```
Chunk [N] edits done — [N accepted, N skipped]. Moving to paragraphs [X–Y].
```

Then begin the next chunk's review.

### End of full session

After the final chunk's edits and the Recurring Patterns summary, show the full session summary:

```
## Session Summary

[N] chunks reviewed · [N] total suggestions · [N] accepted · [N] skipped
```

### Scope

Do not make changes outside the corrections flagged in the chunk feedback. Do not apply changes to paragraphs not yet reviewed.
