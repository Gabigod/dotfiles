#!/usr/bin/env python

import sys
import gi

# Requer as versões corretas das bibliotecas
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib

try:
    # Cria uma instância do player para o Spotify
    player = Playerctl.Player.new('spotify')

    def print_info(player):
        """Função para buscar os metadados e imprimir o status formatado."""
        status = player.get_property('status')
        output = ''

        # Define o ícone com base no status
        if status == 'Playing':
            icon = '' # Ícone de Play
        elif status == 'Paused':
            icon = '' # Ícone de Pause
        else:
            icon = '' # Ícone de Stop/Indisponível

        # Pega o título e o artista
        title = player.get_title()
        artist = player.get_artist()
        
        # Só exibe se houver música tocando ou pausada
        if title and artist:
            output = f"{icon} {title} - {artist}"
        
        # Imprime a saída para a Waybar e força a atualização
        print(output)
        sys.stdout.flush()


    def on_status_change(player, status, manager=None):
        """Callback para quando o status de reprodução (play/pause) muda."""
        print_info(player)

    def on_metadata_change(player, metadata, manager=None):
        """Callback para quando os metadados da música mudam."""
        print_info(player)


    # --- A CORREÇÃO ESTÁ AQUI ---
    # Substituímos o método obsoleto 'on()' pelo método moderno 'connect()'.
    player.connect('playback-status', on_status_change)
    player.connect('metadata', on_metadata_change)

    # Imprime as informações iniciais ao iniciar o script
    print_info(player)

    # Inicia o loop principal do GLib para manter o script rodando e ouvindo os eventos
    main = GLib.MainLoop()
    main.run()

except GLib.Error:
    # Se o Spotify não estiver aberto, o script sai sem erros.
    # Waybar mostrará um módulo vazio.
    sys.exit()
