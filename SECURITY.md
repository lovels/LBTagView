# Security Policy

LBTagView is a UI component and does not process credentials, network traffic, or user secrets directly.

## Reporting a Vulnerability

Please open a GitHub issue with a clear description, reproduction steps, affected versions or commits, and the expected impact. If the issue involves private user data or a supply-chain concern, avoid posting sensitive details publicly and contact the maintainer first when possible.

## Scope

Security-relevant areas include:

- dependency or build-system changes
- release packaging changes
- code paths that could leak user data through logging or diagnostics
- unsafe Objective-C runtime behavior introduced by new code
