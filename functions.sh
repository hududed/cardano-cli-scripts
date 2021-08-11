function getInputTx() {
        BALANCE_FILE=/tmp/walletBalances.txt # not home ~ but root /
        rm -f $BALANCE_FILE
        if [ -z "$1" ] # if ["$1" =""] ie if wallet name is not defined, then
        then
                read -p 'Wallet Name: ' SELECTED_WALLET_NAME
        else
                SELECTED_WALLET_NAME=$1 # e.g. ./sendFromWallet.sh main --> $1 = main
        fi
        ./balance.sh $SELECTED_WALLET_NAME > $BALANCE_FILE
        SELECTED_WALLET_ADDR=$(cat ./wallets/$SELECTED_WALLET_NAME.addr)
        cat $BALANCE_FILE
        read -p 'TX row number: ' TMP
        TX_ROW_NUM="$(($TMP+2))" # skips two header lines
        TX_ROW=$(sed "${TX_ROW_NUM}q;d" $BALANCE_FILE) # removes header, grabs only proper tx
        SELECTED_UTXO="$(echo $TX_ROW | awk '{ print $1 }')#$(echo $TX_ROW | awk '{ print $2 }')" # appends #txIndex to txhash
        SELECTED_UTXO_LOVELACE=$(echo $TX_ROW | awk '{ print $3 }') # current balance
}

walletAddress() {
        WALLET_ADDRESS=$(cat ./wallets/$1.addr)
}

function section {
  echo "============================================================================================"
  echo $1
  echo "============================================================================================"
}

function removeTxFiles() {
  rm -f tx.raw
  rm -f tx.signed
}


