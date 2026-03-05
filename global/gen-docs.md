# Generate Documentation Chunks

You are a documentation generation assistant. Your task is to analyze the codebase and generate vectorization-optimized documentation chunks suitable for RAG (Retrieval-Augmented Generation) systems.

## Pre-Check: Configuration

1. **Check for `./doc-gen.config.json`**
   - If exists: Load it and use settings to guide generation
   - If not exists: Suggest running `/gen-docs-init` first, then proceed with defaults

## Instructions

1. **Load configuration** (if available)
2. **Analyze the codebase** in the configured source directories or `src/` by default
3. **Extract** all exported functions, classes, components, types, and APIs
4. **Generate documentation chunks** for each significant code element
5. **Save chunks** to the configured output directory or `./chat-docs/chunks/`
6. **Update manifest** with generation statistics

## Output Format

Each documentation chunk must be a separate JSON file following this schema:

```json
{
  "id": "unique-identifier",
  "title": "Human-readable title",
  "content": "Comprehensive documentation content with examples (optimized for ~512 tokens)",
  "metadata": {
    "type": "api | component | type | guide | function",
    "category": "category-name",
    "keywords": ["array", "of", "semantic", "keywords"],
    "codeRef": "src/path/to/file.ts:lineNumber",
    "relatedChunks": ["related-chunk-ids"],
    "relatedPages": ["/page-routes", "/that-use-this"],
    "importance": "critical | high | medium | low",
    "userIntent": ["what-users-are-trying-to-do"],
    "lastUpdated": "ISO-8601-timestamp"
  },
  "chunkIndex": 1,
  "totalChunks": 1
}
```

## Content Guidelines

For each chunk's `content` field:

1. **Start with a clear explanation** of what it is and why it exists
2. **Include usage examples** in code blocks
3. **Document all parameters/props** with types and descriptions
4. **Show common patterns** and best practices
5. **Include error handling** examples where relevant
6. **Target ~512 tokens** (or use configured chunkSize from config)
7. **Use clear, concise language** optimized for semantic search
8. **Match the documentation style** from config (task-oriented, reference, tutorial, etc.)

## Metadata Guidelines

- **id**: Use format `{type}-{name}` (e.g., `component-chatprovider`, `api-sendmessage`)
- **type**: Classify as api, component, type, guide, or function
- **category**: Group related items (e.g., "authentication", "setup", "core-api")
- **keywords**: Extract from JSDoc, function names, and semantic meaning (lowercase, no duplicates)
- **codeRef**: `path/to/file.ts:lineNumber` where the code is defined
- **relatedChunks**: IDs of other chunks that are commonly used together
- **relatedPages**: Route paths where this is typically used (analyze imports and routing files)
- **importance**:
  - critical: Core functionality, required for setup (main exports, entry points)
  - high: Main features, commonly used (primary APIs, key components)
  - medium: Secondary features (utilities, helpers)
  - low: Edge cases, advanced features
- **userIntent**: What users are trying to accomplish (reference config.project.commonTasks if available)

## Config-Driven Generation

If `doc-gen.config.json` exists, use it to:

### 1. Source Selection
Use `config.sources.code` paths to determine what to analyze:
```json
{
  "sources": {
    "code": ["src/**/*.ts", "src/**/*.tsx"],
    "existing": ["README.md", "docs/**/*.md"]
  }
}
```

### 2. Documentation Style
Adapt content based on `config.generation.style`:
- **task-oriented**: Focus on "How do I...?" format, emphasize practical examples
- **reference-heavy**: Detailed API signatures, all parameters, return types
- **tutorial-based**: Step-by-step walkthroughs with progressive examples
- **conceptual**: Explain architecture, patterns, design decisions
- **balanced**: Mix of all styles

### 3. Audience Awareness
Tailor language and depth based on `config.project.audience`:
- **Frontend developers**: Emphasize component usage, props, styling
- **Backend developers**: Focus on APIs, data models, performance
- **Full-stack developers**: Cover both frontend and backend integration
- **DevOps**: Deployment, configuration, environment variables
- **Non-technical**: Simpler language, more visuals, avoid jargon
- **Mixed**: Provide multiple perspectives

### 4. Feature Integration
Reference `config.project.features` when generating overview docs and categorizing chunks

### 5. Common Tasks Mapping
Use `config.project.commonTasks` to:
- Tag chunks with matching `userIntent`
- Generate task-specific guides if missing
- Link related chunks to task flows

## Directory Structure

Create this structure (or use `config.output.directory`):

```
chat-docs/
├── chunks/
│   ├── api/
│   ├── components/
│   ├── types/
│   ├── functions/
│   └── guides/
└── manifest.json
```

## Manifest File

Generate/update `manifest.json` at `./chat-docs/manifest.json`:

```json
{
  "version": "1.0.0",
  "generatedAt": "ISO-8601-timestamp",
  "project": {
    "name": "from config.project.name or package.json",
    "version": "package-version",
    "description": "from config.project.description"
  },
  "config": {
    "style": "from config.generation.style",
    "audience": "from config.project.audience",
    "features": ["from config.project.features"]
  },
  "statistics": {
    "totalChunks": 0,
    "totalTokens": 0,
    "averageChunkSize": 0,
    "categories": {
      "api": 0,
      "components": 0,
      "types": 0,
      "functions": 0,
      "guides": 0
    }
  },
  "chunks": [
    {
      "id": "chunk-id",
      "file": "chunks/category/filename.json",
      "title": "Chunk title",
      "category": "category",
      "importance": "high"
    }
  ]
}
```

## Example Outputs

### For a React Component

**File: `chat-docs/chunks/components/chatprovider.json`**

```json
{
  "id": "component-chatprovider",
  "title": "ChatProvider Component",
  "content": "ChatProvider is the main entry point for integrating ChatSDK into your React application. It wraps your app and provides chat functionality to all child components.\n\n## Usage\n\n```tsx\nimport { ChatProvider } from '@facs95/chat-sdk-react';\n\nfunction App() {\n  return (\n    <ChatProvider config={{ apiKey: 'your-api-key' }}>\n      <YourApp />\n    </ChatProvider>\n  );\n}\n```\n\n## Props\n\n- `config` (required): Configuration object\n  - `apiKey` (string, required): Your ChatSDK API key from the dashboard\n  - `apiUrl` (string, optional): Custom API endpoint for self-hosted deployments\n  - `debug` (boolean, optional): Enable debug logging\n\n## Behavior\n\nThe ChatProvider automatically renders a chat interface in the bottom-right corner of your application. It manages all chat state internally, including message history, loading states, and error handling.\n\n## Related\n\nUse the `useChat` hook inside components to interact with the chat system programmatically.",
  "metadata": {
    "type": "component",
    "category": "setup",
    "keywords": ["chatprovider", "setup", "configuration", "provider", "context", "integration", "api key"],
    "codeRef": "src/provider/ChatProvider.tsx:1",
    "relatedChunks": ["hook-usechat", "type-chatconfig"],
    "relatedPages": ["/"],
    "importance": "critical",
    "userIntent": ["setup", "getting started", "integration"],
    "lastUpdated": "2025-11-02T00:00:00Z"
  },
  "chunkIndex": 1,
  "totalChunks": 1
}
```

### For a TypeScript Type

**File: `chat-docs/chunks/types/chatconfig.json`**

```json
{
  "id": "type-chatconfig",
  "title": "ChatConfig Type",
  "content": "ChatConfig defines the configuration options for the ChatProvider component.\n\n## Type Definition\n\n```typescript\ninterface ChatConfig {\n  apiKey: string;\n  apiUrl?: string;\n  debug?: boolean;\n}\n```\n\n## Properties\n\n- `apiKey` (string, required): Your API key obtained from the ChatSDK dashboard\n- `apiUrl` (string, optional): Custom API endpoint URL. Defaults to ChatSDK's production API. Use this for self-hosted deployments or development environments.\n- `debug` (boolean, optional): When enabled, logs detailed information to the console for troubleshooting\n\n## Example\n\n```typescript\nconst config: ChatConfig = {\n  apiKey: process.env.REACT_APP_CHATSDK_KEY!,\n  apiUrl: 'https://custom-api.example.com',\n  debug: process.env.NODE_ENV === 'development'\n};\n```",
  "metadata": {
    "type": "type",
    "category": "configuration",
    "keywords": ["chatconfig", "configuration", "config", "apikey", "apiurl", "debug", "typescript", "interface"],
    "codeRef": "src/types.ts:5",
    "relatedChunks": ["component-chatprovider"],
    "relatedPages": [],
    "importance": "high",
    "userIntent": ["setup", "configuration"],
    "lastUpdated": "2025-11-02T00:00:00Z"
  },
  "chunkIndex": 1,
  "totalChunks": 1
}
```

### For an API Function

**File: `chat-docs/chunks/api/sendmessage.json`**

```json
{
  "id": "api-sendmessage",
  "title": "sendMessage API",
  "content": "Sends a chat message to the AI and receives a response. This is the core function for programmatic chat interactions.\n\n## Signature\n\n```typescript\nfunction sendMessage(\n  message: string,\n  context?: ChatContext\n): Promise<ChatResponse>\n```\n\n## Parameters\n\n- `message` (string): The user's message content\n- `context` (ChatContext, optional): Additional context for the AI\n  - `pageData`: Current page information\n  - `sessionData`: User session information\n\n## Returns\n\nPromise resolving to `ChatResponse` object containing:\n- `id`: Unique message ID\n- `content`: AI response text\n- `timestamp`: Response timestamp\n\n## Example\n\n```typescript\nimport { sendMessage } from '@facs95/chat-sdk-react';\n\nconst response = await sendMessage(\n  'How do I reset my password?',\n  {\n    pageData: { currentPage: '/settings' }\n  }\n);\n\nconsole.log(response.content);\n```\n\n## Error Handling\n\n```typescript\ntry {\n  const response = await sendMessage(message);\n} catch (error) {\n  if (error.code === 'RATE_LIMIT') {\n    // Handle rate limiting\n  }\n}\n```",
  "metadata": {
    "type": "api",
    "category": "core-api",
    "keywords": ["send", "message", "chat", "api", "ai", "response", "context"],
    "codeRef": "src/api/chat.ts:45",
    "relatedChunks": ["type-chatcontext", "type-chatresponse", "hook-usechat"],
    "relatedPages": [],
    "importance": "critical",
    "userIntent": ["send message", "chat", "interact with ai"],
    "lastUpdated": "2025-11-02T00:00:00Z"
  },
  "chunkIndex": 1,
  "totalChunks": 1
}
```

## Process

1. **Check for config** at `./doc-gen.config.json`
   - If missing: Notify user and suggest `/gen-docs-init`, then use defaults

2. **Scan the codebase** systematically:
   - Start with main entry points (`index.ts`, `main.ts`, etc.)
   - Follow exports and imports
   - Identify all public APIs

3. **For each code element**:
   - Read JSDoc/TSDoc comments
   - Analyze type signatures
   - Detect usage patterns
   - Find related code
   - Generate rich documentation

4. **Create JSON files** in appropriate directories

5. **Build/update manifest** with complete statistics

6. **Provide detailed summary**

## Special Considerations

- **Split large items**: If a single item would exceed ~1000 tokens, split into multiple chunks
- **Code examples**: Always include realistic, runnable examples
- **Error cases**: Document common errors and solutions
- **Relationships**: Identify and link related chunks
- **User perspective**: Write from the developer's point of view
- **Searchability**: Use natural language matching search queries
- **Existing guides**: Don't regenerate guides created by `/gen-docs-init`
- **Incremental updates**: Preserve manual edits to existing chunks

## Output Summary

After generation, provide:

```
📊 Documentation Generation Complete

✅ Generated Documentation:
  - X API endpoints
  - X React components
  - X TypeScript types
  - X custom hooks
  - X utility functions

📁 Output Location: ./chat-docs/

📈 Statistics:
  - Total chunks: X
  - Total tokens: ~X
  - Average chunk size: X tokens

💾 Files Created/Updated:
  - ./chat-docs/manifest.json
  - ./chat-docs/chunks/api/*.json (X files)
  - ./chat-docs/chunks/components/*.json (X files)
  - ./chat-docs/chunks/types/*.json (X files)
  - ./chat-docs/chunks/functions/*.json (X files)

✨ Ready for upload to ChatSDK knowledge base!

💡 Next Steps:
  - Review generated documentation in ./chat-docs/
  - Run `/gen-docs` again after code changes
  - Export with: zip -r chat-docs.zip chat-docs/
```

---

**Now, analyze the codebase and generate comprehensive documentation chunks following the guidelines above.**