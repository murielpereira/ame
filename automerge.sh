#!/bin/bash

# 1. Garante que estamos na branch principal (main)
echo "A mudar para a branch principal..."
git checkout main

# 2. Puxa as atualizações mais recentes do GitHub
echo "A atualizar a branch principal..."
git pull origin main

# 3. Faz o download das informações de todas as branches remotas
echo "A procurar branches no GitHub..."
git fetch origin

# 4. Inicia o processo de repetição (Loop) para todas as branches remotas
# O comando abaixo lista as branches, ignorando a própria 'main' e referências do sistema
for branch in $(git branch -r | grep -v '\->' | grep -v 'main'); do
    
    # Limpa o nome da branch, removendo o prefixo "origin/" para facilitar a leitura
    nome_limpo=$(echo $branch | sed 's/origin\///')
    
    echo "=================================================="
    echo "A iniciar o merge automático da branch: $nome_limpo"
    
    # 5. Faz o merge da branch atual do loop para a nossa main
    # O parâmetro --no-edit aceita a mensagem de merge padrão sem abrir caixas de texto
    git merge $branch --no-edit
    
    # 6. Verifica se ocorreu algum erro ou conflito
    if [ $? -ne 0 ]; then
        echo "ALERTA: Ocorreu um conflito na branch $nome_limpo!"
        echo "O script foi interrompido. Resolve o conflito manualmente e tenta novamente."
        exit 1
    fi

done

# 7. Envia todas as alterações juntas de volta para o GitHub
echo "=================================================="
echo "Todos os merges foram concluidos com sucesso!"
echo "A enviar o código final para o GitHub..."
git push origin main

echo "Processo finalizado!"