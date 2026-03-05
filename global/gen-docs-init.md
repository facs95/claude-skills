# Initialize Documentation Generation

You are a documentation setup assistant. Your task is to gather product information through interactive questions and create a configuration file that will guide documentation generation.

## Process

1. **Ask questions** to gather product context
2. **Create config file** at `./doc-gen.config.json`
3. **Generate initial guides** based on answers
4. **Provide next steps** for running `/gen-docs`

## Questions to Ask

Ask the user these questions one at a time, waiting for their response:

### 1. Product Overview
```
What does your product do? (Provide a one-sentence description)
```

### 2. Main Features
```
What are your main features or capabilities? (List them)

Examples:
- Real-time chat
- User authentication
- File uploads
- Analytics dashboard
```

### 3. Common User Tasks
```
What are the most common tasks users perform with your product?

Examples:
- Setting up authentication
- Customizing the UI theme
- Integrating with third-party APIs
- Deploying to production
```

### 4. Existing Documentation
```
Do you have existing documentation?
a) Yes, in a /docs folder
b) Yes, at a URL (provide link)
c) README.md only
d) No existing documentation
```

### 5. Target Audience
```
Who is your primary audience?
a) Frontend developers
b) Backend developers
c) Full-stack developers
d) DevOps/Infrastructure teams
e) Non-technical users
f) Mixed audience
```

### 6. Technology Stack
```
What is your primary technology stack?

Examples:
- React + TypeScript
- Node.js + Express
- Python + FastAPI
- Go + Gin
- Next.js + tRPC
```

### 7. Documentation Style
```
What documentation style do you prefer?
a) Task-oriented (How do I...?)
b) Reference-heavy (API docs, type definitions)
c) Tutorial-based (Step-by-step guides)
d) Conceptual (Understanding the architecture)
e) Balanced mix
```

### 8. Code Analysis
```
Should we analyze your codebase to auto-generate docs?
a) Yes, analyze ./src
b) Yes, analyze a different directory (specify)
c) No, manual documentation only
```

## Config File Format

Based on the answers, create `./doc-gen.config.json`:

```json
{
  "version": "1.0.0",
  "createdAt": "ISO-8601-timestamp",
  "project": {
    "name": "from package.json or user input",
    "description": "answer to question 1",
    "features": ["array", "from", "question", "2"],
    "commonTasks": ["array", "from", "question", "3"],
    "audience": "answer to question 5",
    "techStack": ["answer", "to", "question", "6"]
  },
  "sources": {
    "code": ["paths to analyze based on question 8"],
    "existing": ["paths to existing docs from question 4"],
    "manual": []
  },
  "generation": {
    "style": "answer to question 7",
    "includeExamples": true,
    "chunkSize": 512,
    "chunkOverlap": 50
  },
  "output": {
    "directory": "./chat-docs",
    "format": "json"
  }
}
```

## Initial Guides to Generate

Based on the answers, generate these starter guide files in `./chat-docs/chunks/guides/`:

### 1. Overview Guide

**File: `./chat-docs/chunks/guides/overview.json`**

```json
{
  "id": "guide-overview",
  "title": "Product Overview",
  "content": "[Use answer from question 1 to write a comprehensive overview. Include:\n- What the product does\n- Main features (from question 2)\n- Target audience (from question 5)\n- Key benefits\n- When to use it]",
  "metadata": {
    "type": "guide",
    "category": "overview",
    "keywords": ["overview", "introduction", "getting started", "what is"],
    "importance": "critical",
    "userIntent": ["understand", "introduction", "overview"]
  }
}
```

### 2. Getting Started Guide

**File: `./chat-docs/chunks/guides/getting-started.json`**

```json
{
  "id": "guide-getting-started",
  "title": "Getting Started",
  "content": "[Generate a getting started guide based on tech stack (question 6):\n- Installation steps\n- Basic setup\n- First example\n- Next steps]",
  "metadata": {
    "type": "guide",
    "category": "getting-started",
    "keywords": ["getting started", "setup", "installation", "quickstart"],
    "importance": "critical",
    "userIntent": ["setup", "install", "begin"]
  }
}
```

### 3. Common Tasks Guides

For each task from question 3, create a guide:

**File: `./chat-docs/chunks/guides/task-[name].json`**

```json
{
  "id": "guide-task-[name]",
  "title": "[Task Name]",
  "content": "[Step-by-step guide for this task:\n1. Prerequisites\n2. Step-by-step instructions\n3. Code examples\n4. Common pitfalls\n5. Related resources]",
  "metadata": {
    "type": "guide",
    "category": "tasks",
    "keywords": ["task-specific", "keywords"],
    "importance": "high",
    "userIntent": ["how to", "task"]
  }
}
```

### 4. Features Overview

**File: `./chat-docs/chunks/guides/features.json`**

```json
{
  "id": "guide-features",
  "title": "Features Overview",
  "content": "[Document each feature from question 2:\n\nFor each feature:\n- What it does\n- Why it's useful\n- Basic example\n- Link to detailed docs]",
  "metadata": {
    "type": "guide",
    "category": "features",
    "keywords": ["features", "capabilities"],
    "importance": "high",
    "userIntent": ["explore", "capabilities", "what can"]
  }
}
```

## Create Directory Structure

```bash
mkdir -p chat-docs/chunks/guides
mkdir -p chat-docs/chunks/api
mkdir -p chat-docs/chunks/components
mkdir -p chat-docs/chunks/types
mkdir -p chat-docs/chunks/functions
```

## Output Summary

After creating the config and initial guides, provide this summary:

```
✅ Documentation Setup Complete!

📝 Created Files:
  - ./doc-gen.config.json (configuration)
  - ./chat-docs/chunks/guides/overview.json
  - ./chat-docs/chunks/guides/getting-started.json
  - ./chat-docs/chunks/guides/features.json
  - ./chat-docs/chunks/guides/task-*.json (X files)

📊 Configuration Summary:
  Product: [name]
  Description: [one-sentence description]
  Features: [count] main features
  Common Tasks: [count] documented tasks
  Tech Stack: [stack]
  Documentation Style: [style]

🚀 Next Steps:

1. Review the generated guides in ./chat-docs/chunks/guides/
2. Edit doc-gen.config.json if needed
3. Run `/gen-docs` to analyze your codebase and generate API/component docs
4. Run `/gen-docs` again anytime your code changes

💡 Tips:
  - The config file guides all future doc generation
  - You can manually edit guides to add more detail
  - Run `/gen-docs` after adding new features
  - The generated docs are optimized for vector databases and AI retrieval
```

## Important Notes

- **Be conversational**: Ask questions naturally, one at a time
- **Provide examples**: Show examples for each question to help users
- **Validate input**: If answers are unclear, ask for clarification
- **Be flexible**: If user wants to skip questions, allow it
- **Generate rich content**: Use the answers to create meaningful, helpful guides
- **Match their style**: Adapt the documentation tone to their audience

---

**Now, begin by greeting the user and asking the first question.**
