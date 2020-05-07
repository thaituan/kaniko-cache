FROM node:10-slim AS deps
COPY package.json /tmp
RUN cat /tmp/package.json | xargs -0 -i% node -pe 'o=(%);JSON.stringify({dependencies:o.dependencies,devDependencies:o.devDependencies})' > /tmp/package.deps.json

FROM node:10-slim
WORKDIR /app
COPY --from=deps /tmp/package.deps.json ./package.json
COPY ["yarn.lock", "./"]
RUN yarn install