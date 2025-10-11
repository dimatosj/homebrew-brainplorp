# homebrew-brainplorp

Homebrew tap for [brainplorp](https://github.com/dimatosj/brainplorp) - Workflow automation for TaskWarrior + Obsidian.

## Installation

```bash
brew tap dimatosj/brainplorp
brew install brainplorp
```

## Usage

After installation, run the setup wizard:

```bash
brainplorp setup
```

See the [main repository](https://github.com/dimatosj/brainplorp) for complete documentation.

## What is brainplorp?

brainplorp bridges TaskWarrior (task management) and Obsidian (note-taking) through an intelligent workflow system. It provides both a traditional CLI and MCP (Model Context Protocol) integration for Claude Desktop.

### Core Workflows

1. **Daily workflow** - Generate daily notes with tasks from TaskWarrior
2. **Review workflow** - End-of-day processing of incomplete tasks  
3. **Inbox workflow** - Email → Markdown → TaskWarrior/Obsidian
4. **Notes workflow** - Create and link notes to tasks

## Requirements

- macOS (Homebrew)
- TaskWarrior 3.4.1+ (installed automatically as dependency)
- Obsidian with a vault configured
- Python 3.11+ (installed automatically as dependency)

## Support

- **Issues**: https://github.com/dimatosj/brainplorp/issues
- **Documentation**: https://github.com/dimatosj/brainplorp/tree/master/Docs

## License

MIT License - See [LICENSE](https://github.com/dimatosj/brainplorp/blob/master/LICENSE)
