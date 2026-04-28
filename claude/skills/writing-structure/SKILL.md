---
name: writing-structure
description: Use when the user invokes /writing-structure to review RFCs, PRDs, analytics docs, and other technical/organizational documents. Runs as a multi-step review across structure, flow, arguments, and format, pausing for confirmation between steps.
---

# Writing Structure Review

## Invocation

```
/writing-structure              # Start from Step 1
/writing-structure structure    # Jump to Step 1: Overall Structure
/writing-structure flow         # Jump to Step 2: Section Flow
/writing-structure transitions  # Jump to Step 3: Transitions and Prose Flow
/writing-structure arguments    # Jump to Step 4: Argument Quality
/writing-structure format       # Jump to Step 5: Format
```

If no document is provided, ask the user to share it before proceeding.

## Pyramid Principle

All reviews apply the Pyramid Principle (Minto) as the baseline for good structure:

1. **Lead with the conclusion.** State the answer, recommendation, or finding first. The document should answer "what should I know/do?" before explaining "how did we get here?"
2. **Vertical logic.** Each section or point answers "why?" through the content below it. Every level supports the level above.
3. **Horizontal logic (MECE).** Items at the same level must be mutually exclusive (no overlap) and collectively exhaustive (no gaps).
4. **Group by theme, not by chronology or process.** Arguments are organized by what they mean, not by the order in which they were discovered.

Flag deviations from these principles in each step where they apply.

---

## Before Starting Step 1

If the document doesn't make its intent and audience obvious, ask:

- "Who is the intended audience?" (engineers, executives, stakeholders, mixed?)
- "What is the primary goal — to propose a solution, surface a problem, get approval, or document a decision?"

Do not proceed until these are clear.

---

## Step 1: Overall Structure

Check:
- Does the document lead with the conclusion, recommendation, or key finding (Pyramid Principle)?
- Is the document type evident (RFC, PRD, problem statement, analytics report)?
- Is the structure appropriate for the audience and goal?
- Are expected sections present?
  - **RFC (proposal):** Context, Problem, Proposal, Alternatives, Risks, Decision criteria
  - **RFC (problem):** Context, Problem Statement, Impact, Open Questions
  - **PRD:** Overview, Goals, Non-goals, Requirements, Success Metrics, Open Questions
  - **Analytics doc:** Context, Methodology, Findings, Interpretation, Recommendations
- What is missing that the audience would need to make a decision or take action?

**Output format:**
```
## Step 1: Overall Structure

[Document type and audience assessment.]
[Pyramid check: does it lead with the conclusion? If not, what does it lead with and why is that a problem?]
[What's working.]
[What's missing or misplaced, with specific section names.]
```

After delivering feedback, ask:
> "Continue to Step 2 (Section Flow)?"

---

## Step 2: Logical Flow Between Sections

Check:
- Does each section lead naturally to the next?
- Are there jumps in reasoning between sections?
- Does the vertical logic hold — does each section answer "why?" through the one below it?
- Does horizontal logic hold — are sibling sections MECE (no overlap, no gaps)?
- Is there content that belongs in a different section?
- Is there redundancy across sections?

**Output format:**
```
## Step 2: Section Flow

[What flows well.]
[Vertical logic issues: where sections don't support the level above them.]
[Horizontal logic issues: overlapping or missing sibling sections.]
[Other gaps, jumps, or content out of place — reference actual section titles.]
```

After delivering feedback, ask:
> "Continue to Step 3 (Transitions and Prose Flow)?"

---

## Step 3: Transitions and Prose Flow

Check how sections connect to each other and how prose flows within them.

**Between sections:**
- Does each section end in a way that sets up what follows, or does it stop abruptly?
- Is the logical relationship between sections explicit — contrast, consequence, elaboration — or does the reader have to infer it?
- Are there topic jumps where the reader loses the thread between sections?

**Within sections — paragraph transitions:**
- Does each paragraph connect back to the section's main point?
- Is there a clear thread linking paragraphs, or do they feel like separate items in a list?
- Are there abrupt changes in topic within a section that need a bridge?

**Choppy sentences:**
- Are there clusters of short, disconnected sentences that fragment a single continuous idea?
- Does the rhythm prevent ideas from building on each other?
- Flag when choppiness breaks the logical thread of an argument — not just when it sounds abrupt

**How to present each issue:**

For every transition or flow problem, provide three things:

1. **What's wrong** — quote the relevant text (the abrupt ending, the missing bridge, the choppy passage) and name the problem precisely
2. **Why it matters** — one sentence on how it affects the reader (e.g., "the reader arrives at the Proposal section without understanding why the current approach fails, so the proposal has no anchor")
3. **How to fix it** — suggest the type of correction and give a short illustrative example. The example should show the *form* of the fix, not rewrite the author's actual content. Use `[their content]` as a placeholder for material the author fills in.

Examples of how to present fixes:

> *Missing section bridge:* The "Problem" section ends abruptly and the "Proposal" section starts without connecting the two. A closing sentence on the Problem side could signal the consequence: "This leaves us with [problem outcome], which the following proposal addresses directly." Or an opening sentence on the Proposal side: "Given [the problem just described], we propose..."

> *Paragraph loses the thread:* This paragraph introduces latency as a new concern without connecting it to the scalability argument above. A linking sentence could bridge them: "Scalability is not the only constraint — latency compounds it, because [reason]."

> *Choppy sentences:* "The system fails. It does so under load. This is a known issue." These three sentences each make a separate claim but don't show how they relate. Combine with a causal chain: "The system fails under load — a known issue that [consequence or context]."

**Output format — two passes, always in this order:**

```
## Step 3: Transitions and Prose Flow

### Part A: Section-to-Section Transitions

[Review every boundary between sections, in document order. For each boundary:]
[— Section A → Section B: what works or what is missing/abrupt, with fix and example if needed.]
[— Section B → Section C: ...]
[...]

### Part B: Within-Section Paragraph Flow

[Work through every section in document order. For each section:]

#### [Section name]
[Review paragraph-to-paragraph transitions within this section.]
[For each issue: quoted text → problem → why it matters → how to fix it with example.]
[If the section has no paragraph flow issues, say so in one line.]
```

Do not skip any section in Part B, even if it appears clean.

After delivering feedback, ask:
> "Continue to Step 4 (Argument Quality)?"

---

## Step 4: Argument Quality

Check each section for:
- Is the section's main point stated first (Pyramid Principle at section level)?
- Are arguments grouped by theme (not by chronology or process order)?
- Are sibling arguments MECE within their group?
- Claims supported by evidence or explicit reasoning
- Hidden assumptions (things stated as fact that require justification)
- Counterarguments or alternatives addressed where relevant
- Reasoning that builds progressively vs. circular reasoning
- Positions clear enough for the reader to agree or disagree

**Output format:**
```
## Step 4: Argument Quality

[Per-section notes.]
[Flag: missing topic sentences, ungrouped or overlapping arguments.]
[Flag: unsupported claims, hidden assumptions.]
[Flag: weak or circular reasoning.]
[Quote specific phrases where helpful.]
```

After delivering feedback, ask:
> "Continue to Step 5 (Format)?"

---

## Step 5: Format

Check:
- Lists used where prose would be more persuasive — or prose used where a list or table would be clearer
- Tables used for comparisons and trade-offs
- Heading hierarchy proportional to content depth
- Document length proportionate to topic complexity
- Conclusion or recommendation easy to locate (consistent with Pyramid Principle)

**Output format:**
```
## Step 5: Format

[Specific format suggestions with rationale for each.]
```

After Step 4, deliver a summary:
```
## Priority Improvements

Top changes ranked by impact:
1. [Most impactful]
2. [Second]
3. [Third]
```

No further prompt — review is complete.

---

## Default Mode: Feedback Only

Do not rewrite or restructure the document unless the user explicitly asks. If they do ask for edits, limit changes to the areas flagged in the feedback — do not touch sections that were not flagged.

## Common Issues to Flag

| Issue | How to name it |
|-------|----------------|
| Recommendation buried at the end | "Pyramid violation: lead with the recommendation — the reader shouldn't have to read to the end to know the answer." |
| Sections organized by process/timeline instead of theme | "Sections follow the order of discovery, not the structure of the argument." |
| Sibling sections overlap or leave gaps | "These sections are not MECE — [X] and [Y] cover overlapping ground, and [Z] is not addressed." |
| Reader dropped in without context | "Missing problem context — the reader has no anchor before the proposal." |
| Bullet lists stating positions without building argument | "These bullets present claims but don't connect into a line of reasoning." |
| Alternatives section longer than proposal | "Alternatives are more detailed than the proposal — recalibrate emphasis." |
| Key claims in passive voice | "Several claims are passive, which obscures ownership and accountability." |
| No success criteria | "There's no way for the reader to know when this proposal has succeeded." |
| Abstract goals without measurable outcomes | "Goals are stated aspirationally but lack metrics or observable outcomes." |
| Abrupt section ending with no setup for what follows | "This section ends without signalling where the reader is going next — add a bridge or closing sentence that sets up the following section." |
| Choppy sentences fragmenting a continuous idea | "These sentences each make a separate claim but don't connect — the reader can't tell how they relate. Combine with a causal or consequential link." |
| Paragraph loses thread of section's main point | "This paragraph introduces a new idea without connecting it back to the section's central claim." |
