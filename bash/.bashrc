export COLORTERM=truecolor
[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

alias ls='exa --icons --group-directories-first'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias bye='shutdown -P now'
alias py='venv/bin/python3.14'
alias ir='linux-enable-ir-emitter run'
alias obsidian-sync='/usr/sbin/rclone bisync --track-renames /home/gabriel/Documentos/ECP/ gdrive:ECP --exclude-from /home/gabriel/Documentos/ECP/.exclude.txt --log-file=/home/gabriel/rclone.log -v'

# agiliza a compilação com pandoc para PDF
pdoc() {
	# Pega o nome do arquivo, tira a extensão .md e adiciona .pdf
	local output="${1%.md}.pdf"
	pandoc "$1" -o "$output" && zathura "$output" &
}
ppdoc() {
	local output="${1%.md}.pdf"
	pandoc "$1" -t beamer -o "$output" &
	zathura "$output" &
}

# Compilar, rodar no RARS e despejar todos os registradores em decimal
rars_run() {
	if [ -z "$1" ]; then
		echo "Erro: Forneça um arquivo .asm. Exemplo: rars_run parametros.asm"
		return 1
	fi

	local rars_path="$HOME/Documentos/rars/rars.jar"

	if [ ! -f "$rars_path" ]; then
		echo "Erro: rars.jar não encontrado em $rars_path"
		return 1
	fi

	# nc: modo headless | dec: força exibição em decimal
	# Listamos todos os 32 registradores inteiros para o dump final
	java -jar "$rars_path" nc dec "$1" \
		zero ra sp gp tp t0 t1 t2 s0 s1 a0 a1 a2 a3 a4 a5 a6 a7 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 t3 t4 t5 t6
}

eval "$(zoxide init bash)"
eval "$(starship init bash)"
(cat ~/.cache/wal/sequences &)
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
[[ ${BLE_VERSION-} ]] && ble-attach

# Added by Antigravity CLI installer
export PATH="/home/gabriel/.local/bin:$PATH"
