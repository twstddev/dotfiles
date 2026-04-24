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
/writing-structure arguments    # Jump to Step 3: Argument Quality
/writing-structure format       # Jump to Step 4: Format
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
> "Continue to Step 3 (Argument Quality)?"

---

## Step 3: Argument Quality

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
## Step 3: Argument Quality

[Per-section notes.]
[Flag: missing topic sentences, ungrouped or overlapping arguments.]
[Flag: unsupported claims, hidden assumptions.]
[Flag: weak or circular reasoning.]
[Quote specific phrases where helpful.]
```

After delivering feedback, ask:
> "Continue to Step 4 (Format)?"

---

## Step 4: Format

Check:
- Lists used where prose would be more persuasive — or prose used where a list or table would be clearer
- Tables used for comparisons and trade-offs
- Heading hierarchy proportional to content depth
- Document length proportionate to topic complexity
- Conclusion or recommendation easy to locate (consistent with Pyramid Principle)

**Output format:**
```
## Step 4: Format

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
