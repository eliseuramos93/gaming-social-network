FROM ruby:3.3.0

# Instalando dependências do Rails
RUN apt-get update -qq

# Criando diretório de trabalho
RUN mkdir /gaming_social_network
WORKDIR /gaming_social_network

# Copiando Gemfile e Gemfile.lock para o contêiner
COPY Gemfile Gemfile.lock ./

# Instalando gems
RUN bundle install

# Copiando o código para o contêiner
COPY . .

# Expondo a porta 3000
EXPOSE 3000

# Comando padrão para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]