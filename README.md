## Summary | Sumário

- [About | Sobre](#about-sobre)
- [How to run | Como rodar](#how-to-run-como-rodar)
- [Useful Links | Links Úteis](#useful-links-links-uteis)

## About | Sobre

This repository was motivated by a personal interest in developing a `Rails` like api, with only pure ruby and only a few gems. So I started my own little "framework".

You can see a usage example on [examples/api/app](examples/api/app.rb)

It's mostly a metaprogramming, system design and performance exercise. The `/core` path contains our resources. Currently, there are 3 domains:

- *Data*: Simple database connector. Needs to be improved so stops depending on `Sequel`for our abstractions. [Access usage](examples/api/data/models/user.rb) and [migration usage](examples/api/data/migrations/01.rb)
- *Handle*: Simple request handler using `Rack`and `json`only. Needs to be improved for secure connections, it could be configurable. [Usage](examples/api/handlers/users.rb)
- *Route*: Simple route generation abstraction, no gems. Needs to be improved for a resource-oriented writing approach. [Usage](examples/api/routes.rb)

I designed it to be flexible and lightweight so any domain can be used by itself or they all can be used together with any ruby application. It was also designed to have a developer friendly api for usage

Needs to be improved also for our app config to be easy and more [benchmarking](benchmark/api.rb) needs to be done

## How to run | Como rodar

First, go to `examples/api/app.rb` and fullfil your database requirements. Database should be already created, but my config will run migrations all necessary on app start.

Then, with ruby installed on your system (`v 3.2`), run:

```bash
bundle install
ruby examples/api/app.rb
```

I'tll start a process on port 3030. You can test API responses using postman

--------------------------------------------------------------------------------------------

Primeiro, edite o arquivo `examples/api/app.rb` com os dados do seu banco local. O banco precisa ser criado antes que a aplicação seja inicializada, mas a configuração do exemplo já rodará as migrations necessárias ao inicializar a aplicação.

Depois com o ruby `v 3.2` installado, rode: 

```bash
bundle install
ruby examples/api/app.rb
```

Um processo será inicializado na porta 3030. Você pode testar as respostas da API pelo postman

## Useful links | Links úteis

- [Crafting Interpreters](https://craftinginterpreters.com)
- [So you want to write an interpreter?](https://www.youtube.com/watch?v=LCslqgM48D4)
- [Let’s Build A Simple Interpreter. Part 1.](https://ruslanspivak.com/lsbasi-part1/)
- [Challenge](https://github.com/aripiprazole/rinha-de-compiler/)
