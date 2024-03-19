FROM ruby:3.3.0

# Instalando dependências do Rails
RUN apt-get update -qq
RUN apt-get install -y npm 
RUN npm install -g yarn -y
RUN npm install npx -g -y

# Criando diretório de trabalho
RUN mkdir /gaming_social_network
WORKDIR /gaming_social_network

# Copiando Gemfile e Gemfile.lock para o contêiner
COPY Gemfile Gemfile.lock ./

# Instalando gems
RUN bundle install
RUN yarn install
RUN rails css:install:bootstrap
RUN rails js:install:esbuild

# Instalando Chrome no container
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
RUN sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update
RUN apt-get install -y google-chrome-stable

# Copiando o código para o contêiner
COPY . .

# Expondo a porta 3000
EXPOSE 3000

# Comando padrão para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]