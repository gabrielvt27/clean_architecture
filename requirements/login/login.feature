# BDD - Behavior Driven Development
# mostrar a visão de alguém que não é técnico
# como um cliente espera que o sistema se comporte
Feature: Login
Como um cliente
Quero poder acessar minha conta e me manter logado
Para que eu possa ver e responder enquetes de forma rápida

Cenário: Credenciais Válidas
Dado que o cliente informou credenciais válidas
Quando solicitar para fazer login
Então o sistema deve enviar o usuário para a tela de pesquisas
E mater o usuário conectado

Cenário: Credenciais Inválidas
Dado que o cliente informou credenciais inválidas
Quando solicitar para fazer login
Então o sistema deve retornar uma mensagem de erro