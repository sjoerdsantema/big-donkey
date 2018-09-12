#!/bin/bash
echo " "
cat sentia.txt
echo " "
echo " "
echo "What would you like to do? Choices are: sync, delete, create or quit:" 
read wish

if [ "$wish" == "create" ] ; then
        echo "As you wish, we shall create a new stack."
        aws cloudformation create-stack --stack-name 'Big-Donkey' --template-url 'https://s3.us-east-2.amazonaws.com/big-donkey/parent-stack.yaml' --capabilities CAPABILITY_IAM 
        sleep 10
        clear
        ./helper.sh 
        exit 1
elif [ "$wish" == "sync" ] ; then
        echo " "
        aws s3 sync . s3://big-donkey --exclude '*' --include '*.yaml' 
        aws cloudformation update-stack --stack-name 'Big-Donkey' --template-url 'https://s3.us-east-2.amazonaws.com/big-donkey/parent-stack.yaml' 
        echo "We shall bring the news to every corner and s3 bucket"
        sleep 10
        clear
        ./helper.sh 
        exit 1
elif [ "$wish" == "delete" ] ; then
        echo "We shall destroy what you have created" 
        aws cloudformation delete-stack --stack-name 'Big-Donkey'
        sleep 10
        clear
        ./helper.sh  
        exit 1
elif [ "$wish" == "quit" ] ; then
        echo "Goodbye.."  
        exit 1
else
        echo "Please adhere to my command. I am giving you a second chance"
        sleep 2
        clear
        ./helper.sh
fi





