extends Node

var key_count := 0
var next_spawn_point_door := ""
var next_spawn_point := ""
var dialogue_active := false
var chaves = {}

func pegar_chave(nome_chave: String):
	chaves[nome_chave] = true

func tem_chave(nome_chave: String) -> bool:
	return chaves.has(nome_chave) and chaves[nome_chave]
