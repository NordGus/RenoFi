FROM ruby:3.2

RUN apt update -y && apt upgrade -y && apt install nano -y

WORKDIR /var/app

COPY . .

RUN bundle install

CMD ["rspec"]
