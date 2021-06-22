echo -e "--------------- --------------- --------------- --------------- --------------- ---------------"
echo -e "\n🚀 🇧🇷 Configurando ambiente para que a aplicação conecte ao DataStax Astra DB."
echo -e "🚀 🇺🇸 Setting application environment to connect to DataStax Astra DB connect.\n"
if [[ -z "$ASTRA_DB_CLIENT_ID" ]] || [[ -z "$ASTRA_DB_CLIENT_SECRET" ]] || [[ -z "$ASTRA_DB_ADMIN_TOKEN" ]]; then
    echo -e "🇧🇷➡ A Aplicação necessita de informações do token de conexão."
    echo -e "    Acesse https://astra.datastax.com, registre-se ou faça login."
    echo -e "    Clique em 'Current Organization' -> 'Organization Settings' no menu à esquerda."
    echo -e "    Clique em 'Token Management' no novo menu à esquerda."
    echo -e "    Selecione 'Database Administrator' no campo 'Role' e clique em 'Generate Token'"
    echo -e "🇺🇸➡ Application needs connection token information."
    echo -e "    Go to https://astra.datastax.com and register or login."
    echo -e "    Click on 'Current Organization' -> 'Organization Settings' in the menu bar at the left."
    echo -e "    Click on 'Token Management' in the new menu bar at the left."
    echo -e "    Choose 'Database Administrator' in the Role selection and click 'Generate Token'\n"
    if [[ -z "$ASTRA_DB_CLIENT_ID" ]]; then
        echo -e "CLIENT ID"
        echo -e "❗🇧🇷 Copie o valor do primeiro campo (Client Id) e cole aqui:"
        echo -e "❗🇺🇸 Copy the value of first field (Client Id) and paste it here:"
        read -r ASTRA_DB_CLIENT_ID
        export ASTRA_DB_CLIENT_ID=${ASTRA_DB_CLIENT_ID}
        gp env ASTRA_DB_CLIENT_ID=${ASTRA_DB_CLIENT_ID} &>/dev/null
        echo -e "\n💡🇧🇷 Valor atribuido para a variável de ambiente ASTRA_DB_CLIENT_ID."
        echo -e "    Para persistir essa atribuição, é necessário adicionar a linha abaixo em um script de profile:"
        echo -e "💡🇺🇸 Value assigned to environment ASTRA_DB_CLIENT_ID."
        echo -e "    To persist this assignment, you need to add the line below in a profile script:\n"
        echo -e "        ASTRA_DB_CLIENT_ID=${ASTRA_DB_CLIENT_ID}\n"
    else
        echo -e "✅ 🇧🇷 ASTRA_DB_CLIENT_ID já settada."
        echo -e "  🇺🇸 ASTRA_DB_CLIENT_ID already setted."
    fi
    if [[ -z "$ASTRA_DB_CLIENT_SECRET" ]]; then
        echo -e "CLIENT SECRET"
        echo -e "❗🇧🇷 Copie o valor do segundo campo (Client Secret) e cole aqui:"
        echo -e "❗🇺🇸 Copy the value of second field (Client Secret) and paste it here:"
        read -r ASTRA_DB_CLIENT_SECRET
        export ASTRA_DB_CLIENT_SECRET=${ASTRA_DB_CLIENT_SECRET}
        gp env ASTRA_DB_CLIENT_SECRET=${ASTRA_DB_CLIENT_SECRET} &>/dev/null
        echo -e "\n💡🇧🇷 Valor atribuido para a variável de ambiente ASTRA_DB_CLIENT_SECRET."
        echo -e "    Para persistir essa atribuição, é necessário adicionar a linha abaixo em um script de profile:"
        echo -e "💡🇺🇸 Value assigned to environment ASTRA_DB_CLIENT_SECRET."
        echo -e "    To persist this assignment, you need to add the line below in a profile script:\n"
        echo -e "        ASTRA_DB_CLIENT_SECRET=${ASTRA_DB_CLIENT_SECRET}\n" 
    else
        echo -e "✅ 🇧🇷 ASTRA_DB_CLIENT_SECRET já settada."
        echo -e "  🇺🇸 ASTRA_DB_CLIENT_SECRET already setted."
    fi
    if [[ -z "$ASTRA_DB_ADMIN_TOKEN" ]]; then
        echo -e "CLIENT TOKEN"
        echo -e "❗🇧🇷 Copie o valor do terceiro campo (Token) e cole aqui:"
        echo -e "❗🇺🇸 Copy the value of third field (Token) and paste it here:"
        read -r ASTRA_DB_ADMIN_TOKEN
        export ASTRA_DB_ADMIN_TOKEN=${ASTRA_DB_ADMIN_TOKEN}
        gp env ASTRA_DB_ADMIN_TOKEN=${ASTRA_DB_ADMIN_TOKEN} &>/dev/null
        echo -e "\n💡🇧🇷 Valor atribuido para a variável de ambiente ASTRA_DB_ADMIN_TOKEN."
        echo -e "    Para persistir essa atribuição, é necessário adicionar a linha abaixo em um script de profile:"
        echo -e "💡🇺🇸 Value assigned to environment ASTRA_DB_ADMIN_TOKEN."
        echo -e "    To persist this assignment, you need to add the line below in a profile script:\n"
        echo -e "        ASTRA_DB_ADMIN_TOKEN=${ASTRA_DB_ADMIN_TOKEN}\n"
    else
        echo "✅ 🇧🇷 ASTRA_DB_ADMIN_TOKEN já settada."
        echo "  🇺🇸 ASTRA_DB_ADMIN_TOKEN already setted."
    fi
    echo -e ""
else
  echo -e "✅ 🇧🇷 ASTRA_DB_CLIENT_ID, ASTRA_DB_CLIENT_SECRET e ASTRA_DB_ADMIN_TOKEN já settadas."
  echo -e "   🇺🇸 ASTRA_DB_CLIENT_ID, ASTRA_DB_CLIENT_SECRET and ASTRA_DB_ADMIN_TOKEN already setted.\n"
fi
SECURE_BUNDLE_FILE_NAME=secure-connect-db.zip
if [ ! -f ./${SECURE_BUNDLE_FILE_NAME} ]; then
    echo -e "🚀 🇧🇷 Obtendo o Secure Connect Bundle do seu database para o arquivo ${SECURE_BUNDLE_FILE_NAME}."  
    echo -e "    Retorne para https://astra.datastax.com"
    echo -e "    Clique no seu database no menu esquerdo do Astra UI"
    echo -e "    💡 Caso necessário, crie um novo database."    
    echo -e "🇺🇸➡ Downloading Secure Connect Bundle to file ${SECURE_BUNDLE_FILE_NAME}."
    echo -e "    Return to https://astra.datastax.com"  
    echo -e "    Click on your database from the left panel from the Astra UI"
    echo -e "    💡 If necessary, create a new database.\n"
    echo -e "❗🇧🇷 Copie o Cluster ID usando o widget de copiar à direita do ID e cole aqui:"
    echo -e " 🇺🇸 Copy the Cluster ID using the copy widget to the right of the ID and paste it here:"
    read -r ASTRA_DB_ID
    export ASTRA_DB_ID="${ASTRA_DB_ID}"
    echo -e "\nBundle URL..."
    DBbyID=$(curl -s --request GET \
    --url "https://api.astra.datastax.com/v2/databases/${ASTRA_DB_ID}?include=nonterminated&provider=all&limit=25" \
    --header "authorization: Bearer ${ASTRA_DB_ADMIN_TOKEN}" \
    --header 'content-type: application/json')
    FIRST_DB_SECURE_BUNDLE_URL=$(echo "${DBbyID}" | jq -c '.info.datacenters[0].secureBundleUrl')
    export ASTRA_SECURE_BUNDLE_URL=${FIRST_DB_SECURE_BUNDLE_URL}
    echo $ASTRA_SECURE_BUNDLE_URL
    # Download the secure connect bundle
    echo -e "\nDownloading..."
    curl -s -L $(echo $FIRST_DB_SECURE_BUNDLE_URL | sed "s/\"//g") -o ${SECURE_BUNDLE_FILE_NAME}
else
  echo "✅ 🇧🇷 Arquivo secure-connect-db.zip (Secure Connect Bundle do Database) já existe."  
  echo "   🇺🇸 File secure-connect-db.zip (Database Secure Connect Bundle) already exists." 
fi
echo -e "\n🆗 🇧🇷 Setup Finalizado | 🇺🇸 Setup Completed"
echo -e "\n💡🇧🇷 Lembre-se, para persistir as atribuições das variáveis de ambiente, é necessário adiciciona-las em um script de profile. (ex: \$HOME/.bashrc)."
echo -e "💡🇺🇸 Remember, to persist the OS environments assignments, you need to add in a profile script (ex: \$HOME/.bashrc).\n"
echo -e "        ASTRA_DB_CLIENT_ID=${ASTRA_DB_CLIENT_ID}"
echo -e "        ASTRA_DB_CLIENT_SECRET=${ASTRA_DB_CLIENT_SECRET}" 
echo -e "        ASTRA_DB_ADMIN_TOKEN=${ASTRA_DB_ADMIN_TOKEN}"