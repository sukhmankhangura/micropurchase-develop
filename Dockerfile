FROM ruby:2.3.1
RUN set -x \
    && apt-get update -qq \
    && apt-get install -y \
          build-essential \
          libpq-dev \
          nodejs \
          nodejs-legacy \
          npm \
    && npm install -g phantomjs-prebuilt \
    && gem install foreman \
    && curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it \
    && chmod +x /usr/local/bin/wait-for-it

WORKDIR /app

COPY Gemfile Gemfile.lock /app
RUN bundle install --frozen

COPY docker-entrypoint.sh /
ENTRYPOINT /docker-entrypoint.sh
CMD --

COPY . /app