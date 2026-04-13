# AGENTS.md

## Purpose
This file provides context and operational guidelines for AI agents working within this repository. This repository is my (Laureano's) personal configuration management system for my local development environment.

## Mission Statement
When assisting with this repository, your goal is to help me maintain, refine, and expand my setup while respecting the existing patterns and ensuring the stability of my local tools.

## Core Principles for AI Agents

1. **Respect My Workflow**: Understand that these configurations are tailored to my specific needs and hardware. Before suggesting major changes, consider how they might impact my existing workflows.
2. **Maintain Pattern Consistency**: When adding new tools or configurations, follow the existing directory structure and naming conventions.
3. **Safety First (Shell Scripts)**: This repository contains automation scripts (`llama_cpp/`, `opencode/`) that interact directly with my local hardware and services. Be extremely cautious when modifying or creating shell scripts. Always prioritize stability and error handling.
4. **Documentation is Mandatory**: Any change that introduces a new tool, a significant script modification, or a new configuration must be documented in the `README.md`.
5. **Contextual Awareness**: Remember that these files are not just "code"—they are instructions for my infrastructure. Changes here can affect my DNS, my editor, and my ability to run local LLMs.

## Technical Context

* **Infrastructure**: Technitium (DNS) for network-wide ad and spam filtering.
* **AI/LLM**: `llama.cpp` for running models, with various quantization and build scripts.
* **Editor**: Neovim, using the `LazyVim` framework.
* **Development Environment**: `opencode` for enabling agentic workflows.
