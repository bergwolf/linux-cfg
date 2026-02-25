FROM node:25-bullseye

RUN curl -fsSL https://bun.com/install | bash
RUN ln -s /root/.bun/bin/bun /root/.bun/bin/node
RUN /root/.bun/bin/bun install -g opencode-ai

RUN /root/.bun/bin/opencode run -m opencode/kimi-k2.5-free \
"Install and configure oh-my-opencode by following the instructions here: \
https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/refs/heads/master/docs/guide/installation.md \
Note that I don't have any model service subscriptions at all."

RUN wget https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.opencode/INSTALL.md

RUN sed -ie 's|~|/root/|g' /INSTALL.md

RUN /root/.bun/bin/opencode run -m opencode/kimi-k2.5-free \
	"Install superpower skills by following instructions from /INSTALL.md"
