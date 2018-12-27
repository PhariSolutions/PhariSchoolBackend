# Image
FROM ruby:2.5.3
RUN apt-get update \
  && apt-get install -y postgresql postgresql-contrib \
  && apt-get install sudo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Preparing environment
RUN mkdir app
COPY . /app
WORKDIR /app

# App's dependencies
RUN bundle install --binstubs

# DB for tests
USER postgres
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.6/main/pg_hba.conf

# Exposing app to 80"s port
ENTRYPOINT /etc/init.d/postgresql start \
           && psql --command "ALTER USER postgres WITH PASSWORD 'postgres';" \
           && bin/rake db:create db:migrate && bin/rspec

EXPOSE 80
