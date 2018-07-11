FROM ruby:2.5.1-slim

# Ensure that our apt package list is updated and has basic build packages.
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs netcat curl
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH="${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin:${PATH}"

# Add bundle entry point to handle bundle cache
RUN mkdir -p /docker
ADD /docker /docker
RUN chmod +x /docker/entrypoint.sh
RUN chmod +x /docker/one-off-task.sh
RUN chmod +x /docker/full-run.sh
ENTRYPOINT ["/docker/entrypoint.sh"]

# Bundle installs with binstubs to our custom /bundle/bin volume path. 
# Let system use those stubs.
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Add app files into docker image
RUN mkdir -p /myapp
WORKDIR /myapp

COPY .ruby-version /myapp/.ruby-version
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
#COPY . /myapp
