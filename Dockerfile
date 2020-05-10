FROM ruby:2.7.1-alpine3.11

# Install required libraries and dependencies
RUN apk add --update --no-cache \
      build-base \
      nodejs \
      tzdata \
      libxml2-dev \
      libxslt-dev \
      bash \
      postgresql-dev

# Set timezone
RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN echo "America/Sao_Paulo" >  /etc/timezone

# Update CA Certificates
RUN update-ca-certificates

# Set rails env
ARG bundle_options_var='development test'

# path of container
ENV APP_ROOT /app

# application folder
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# Copy files to application folder
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

# Install gems
RUN bundler install
RUN bundle config --global frozen 1
RUN bundle install $bundle_options_var

# Copy all project files to application folder inside container
COPY . $APP_ROOT

# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]