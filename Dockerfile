FROM ruby:2.5.0

RUN apt-get update && \
    apt-get install -y nodejs --no-install-recommends sudo && \
    apt-get clean

ENV APP_DIR /home/rails/source/

RUN mkdir -p $APP_DIR

WORKDIR $APP_DIR

COPY Gemfile* $APP_DIR

RUN bundle install

COPY . $APP_DIR

EXPOSE 3000:3000

CMD ["rails", "server", "-b", "0.0.0.0"]
