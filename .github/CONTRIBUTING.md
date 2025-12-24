# CONTRIBUTING

## Reporting Issues

If you ever encounter a bug in-game, the best way to let a coder know about it is with our GitHub Issue Tracker. Please make sure you use the supplied issue template, and include the round ID for the server.

(If you don't have an account, making a new one takes only one minute.)

If you have difficulty, ask for help in the #coding-general channel on our discord.

## Introduction

Hello and welcome to Shiptest's contributing page. You are here because you are curious or interested in contributing - thank you! Everyone is free to contribute to this project as long as they follow the simple guidelines and specifications below; at Shiptest, we strive to maintain code stability and maintainability, and to do that, we need all pull requests to hold up to those specifications. It's in everyone's best interests - including yours! - if the same bug doesn't have to be fixed twice because of duplicated code.

First things first, we want to make it clear how you can contribute (if you've never contributed before), as well as the kinds of powers the team has over your additions, to avoid any unpleasant surprises if your pull request is closed for a reason you didn't foresee.

## Getting Started

Shiptest doesn't usually have a list of goals and features to add; we instead allow freedom for contributors to suggest and create their ideas for the game. That doesn't mean we aren't determined to squash bugs, which unfortunately pop up a lot due to the deep complexity of the game. Here are some useful starting guides, if you want to contribute or if you want to know what challenges you can tackle with zero knowledge about the game's code structure.

<!--> This needs to be updated still

If you want to contribute the first thing you'll need to do is [set up Git](https://shiptest.net/wiki/Setting_up_git) so you can download the source code.
After setting it up, optionally navigate your git commandline to the project folder and run the command: 'git config blame.ignoreRevsFile .git-blame-ignore-revs'

<!-->

You can of course, as always, ask for help on the discord channels, or the forums, We're just here to have fun and help out, so please don't expect professional support.

## Meet the Team

### Project Lead

The Project Lead is responsible for controlling, adding, and removing maintainers from the project. In addition to filling the role of a normal maintainer, they have sole authority on who becomes a maintainer, as well as who remains a maintainer and who does not. The Project Lead also has the final say on what gameplay changes are added to and removed from the game. He or she has full veto power on any feature or balance additions, changes, or removals, and attempts to establish a universally accepted direction for the game.

### Head Coder
The Head Coder controls the quality of code, maintainability of the project, CI, and unit tests. They have a say over features, but primarily based on the merit of the code, e.g., long-term maintenance for complex features.

### Lore Head
Much of the Lore heads' work is done outside github itself, much of it in doucments or wiki pages; however, lore-maints can still be manually requested on a pr if it has a significant lore implication.

### Head Spriter

The Head Spriter controls sprites and aesthetic that get into the game. While sprites for brand-new additions are generally accepted regardless of quality, modified current art assets fall to the Head Spriter, who can decide whether or not a sprite tweak is both merited and a suitable replacement.

They also control the general "perspective" of the game - how sprites should generally look, especially the angle from which they're viewed. An example of this is the 3/4 perspective, which is a bird's eye view from above the object being viewed.

### Head Mapper

The Head Mapper controls ships and all variants of shuttles, including their balance and cost. Final decision on whether or not a shuttle is added is at their discretion and cannot be vetoed by anyone other than the Project Lead.

### Maintainers

Maintainers are quality control. If a proposed pull request doesn't meet the following specifications, they can request you to change it, or simply just close the pull request. Maintainers can close a pull request for the following reasons: The pull request doesn't follow the guidelines, excessively undocumented changes, failure to comply with coding standards. Note that maintainers should generally help bring a pull request up to standard instead of outright closing the PR; however if the pull request author does not comply with the given guidelines or refuses to adhere to the required coding standards the pull request will be closed. **Maintainers must have a valid reason to close a pull request and state what the reason is when they close the pull request.**

Maintainers can revert your changes if they feel they are not worth maintaining or if they did not live up to the quality specifications.

Unlike most other servers, we have a more formal seperation between code-tainers, map-tainers, sprite-tainers, and even lore-tainers (lore curators). They operate semi-independently and prs that makes meaninful changes to parts of the game require a approval from each relevent team.
Examples of changes that dont require approval
- A few fluff sprites for a map.
- Extreamly simple subtypes for a pr that adds clothing sprites.

Game balance changes (map balances changes will still require maptainer approval) despite being a code change, can be reviewed by any maintainer or even admin.

### Maintainer Code of Conduct

Maintainers are expected to maintain the codebase in its entirety. This means that maintainers are in charge of pull requests, issues, and the Git discussion board. Maintainers have a say on what will and will not be merged. Maintainers should assign themselves to pull requests that they are claiming and reviewing, and should respect when others assign themselves to a pull request and not interfere except in situations where they believe a pull request to be heavily detrimental to the codebase or its playerbase. **Maintainers are not server admins and should not use their rank on the server to perform admin related tasks except where asked to by a Headmin or higher.**

<details>
<summary>Maintainer Guidelines</summary>

These are the few directives we have for project maintainers.

- Do not merge PRs you create.
- Do not merge PRs until 24 hours have passed since they were opened. Exceptions include:
  - Emergency fixes or CI fixes.
    - Try to get secondary maintainer approval before merging if you can.
  - PRs with empty commits intended to generate a changelog.
- Do not close PRs purely for breaking a template if the same information is contained without it.

These are not steadfast rules as maintainers are expected to use their best judgment when operating.

</details>

## Development Guides

#### Writing readable code

[Style guide](/.github/guides/CODE_STYLE.md)

#### Writing sane code

[Code standards](/.github/guides/CODE_STANDARDS.md)

#### Writing understandable code

[Autodocumenting code](/.github/guides/AUTODOC.md)

#### Misc

- [AI Datums](/code/datums/ai/learn_ai.md)
- [Embedding TGUI Components in Chat](/tgui/docs/chat-embedded-components.md)
- [Hard Deletes](/.github/guides/HARDDELETES.md)
- [MC Tab Guide](/.github/guides/MC_tab.md)
- [Policy Configuration System](/.github/guides/POLICYCONFIG.md)

## Pull Request Process

There is no strict process when it comes to merging pull requests. Pull requests will sometimes take a while before they are looked at by a maintainer; the bigger the change, the more time it will take before they are accepted into the code. Every team member is a volunteer who is giving up their own time to help maintain and contribute, so please be courteous and respectful. Here are some helpful ways to make it easier for you and for the maintainers when making a pull request.

- If you are adding a large feature, developing a new map, or any other large change, there is a strong expectation that you get it preapproved by making a post in the Discord #dev-projects forum. This allows you to get your changes preapproved by a maintainer to avoid a large amount of wasted work if your project is not one we are interested in. (e.g, a new map for an already bloated faction, or a feature that does not fit the setting or gameplay loop)
