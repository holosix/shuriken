function get_option() {
    # zsh
    IFS=$'\n' arr=($(echo $1))
    len=${arr[(I)$arr[-1]]}

    # bash
    # IFS=$'\n' read -d '' -r -a arr <<< "$1"    
    # len=${#arr[@]}

    if [ "$len" -lt 2 ]; then
        echo $arr
    else
        select choice in "${arr[@]}";
        do
            case "$choice" in
                "") break ;;
                *) echo "$choice" ; break ;;
            esac
        done
    fi
}

function k8s-get-job() {
    if [ -z "$1" ]
    then
        kubectl get job --all-namespaces
        return;
    fi
    kubectl get job --all-namespaces | grep -i $1
}

function k8s-get-pod() {
    if [ -z "$1" ]
    then
        kubectl get pod --all-namespaces -o wide
        return;
    fi
    kubectl get pod --all-namespaces -o wide | grep -i $1
}

function k8s-get-node() {
    if [ -z "$1" ]
    then
        kubectl get node --all-namespaces -o wide
        return;
    fi
    kubectl get node --all-namespaces -o wide | grep -i $1
}

function k8s-get-secret() {
    if [ -z "$1" ]
    then
        kubectl get secret --all-namespaces
        return;
    fi
    kubectl get secret --all-namespaces | grep -i $1
}

function k8s-get-pv() {
    if [ -z "$1" ]
    then
        kubectl get pv --all-namespaces
        return;
    fi
    kubectl get pv --all-namespaces | grep -i $1
}

function k8s-describe-pv() {
    menu=$(kubectl get pv --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl describe pv -n $namespace $pod "
    echo "RUN: "$command
    eval $command
}

function k8s-get-pvc() {
    if [ -z "$1" ]
    then
        kubectl get pvc --all-namespaces
        return;
    fi
    kubectl get pvc --all-namespaces | grep -i $1
}

function k8s-describe-pvc() {
    menu=$(kubectl get pvc --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl describe pvc -n $namespace $pod "
    echo "RUN: "$command
    eval $command
}

function k8s-get-service() {
    if [ -z "$1" ]
    then
        kubectl get service --all-namespaces
        return;
    fi
    kubectl get service --all-namespaces | grep -i $1
}

function k8s-get-deployment() {
    if [ -z "$1" ]
    then
        kubectl get deployment --all-namespaces
        return;
    fi
    kubectl get deployment --all-namespaces | grep -i $1
}

function k8s-get-ingress() {
    if [ -z "$1" ]
    then
        kubectl get ingress --all-namespaces
        return;
    fi
    kubectl get ingress --all-namespaces | grep -i $1
}

function k8s-port-forward() {
    if [ -z "$1" ]
    then
        echo "The arguments for this command:";
        echo "\t \$1: Service name you want to port forwarding e.g. ai-frontend";
        echo "\t \$2: Forward your service's port to localhost port e.g. 8080:80";
        return;
    fi

    menu=$(kubectl get service --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl port-forward -n $namespace service/$pod $2"
    echo "RUN: "$command
    eval $command
}

function k8s-exec-pod() {
    menu=$(kubectl get pod --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl exec -it $pod -n $namespace -- "$2
    echo "RUN: "$command
    eval $command
}

function k8s-delete-job() {
    menu=$(kubectl get job --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl delete job -n $namespace $pod"
    echo "RUN: "$command
    eval $command
}

function k8s-delete-deployment() {
    menu=$(kubectl get deployment --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl delete deployment -n $namespace $pod"
    echo "RUN: "$command
    eval $command
}

function k8s-delete-service() {
    menu=$(kubectl get service --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl delete service -n $namespace $pod"
    echo "RUN: "$command
    eval $command
}

function k8s-delete-pod() {
    menu=$(kubectl get pod --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl delete pod -n $namespace $pod"
    echo "RUN: "$command
    eval $command
}

function k8s-describe-deployment() {
    menu=$(kubectl get deployment --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl describe deployment -n $namespace $pod "
    echo "RUN: "$command
    eval $command
}

function k8s-describe-secret() {
    menu=$(kubectl get secret --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl describe secret -n $namespace $pod "
    echo "RUN: "$command
    eval $command
}

function k8s-read-secret() {
    menu=$(kubectl get secret --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command=" kubectl get secret -n $namespace $pod -o jsonpath=\"{.data.$2}\" | base64 --decode"
    echo "RUN: "$command
    eval $command
}

function k8s-describe-service() {
    menu=$(kubectl get service --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl describe service -n $namespace $pod "
    echo "RUN: "$command
    eval $command
}

function k8s-describe-ingress() {
    menu=$(kubectl get ingress --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl describe ingress -n $namespace $pod "
    echo "RUN: "$command
    eval $command
}

function k8s-config-set() {
    menu=$(kubectl config get-contexts | grep -i $1)
    value=$(get_option "$menu")
    pod=$(echo $value | awk '{print $1}')
    command="kubectl config use-context $pod "
    echo "RUN: "$command
    eval $command
}

function k8s-log-pod() {
    menu=$(kubectl get pod --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')

    if [ -z "$2" ]
    then
        command="kubectl logs -f --tail 100 -n $namespace $pod"
    else
        command="kubectl logs -f --tail 100 -n $namespace $pod -c $2"
    fi

    echo "RUN: "$command
    eval $command
}

function k8s-tail-pod() {
    menu=$(kubectl get pod --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl logs --tail 100 -n $namespace $pod"
    echo "RUN: "$command
    eval $command
}

function k8s-describe-node() {
    menu=$(kubectl get node | grep -i $1)
    value=$(get_option "$menu")
    pod=$(echo $value | awk '{print $1}')
    command="kubectl describe node $pod"
    echo "RUN: "$command
    eval $command
}

function k8s-describe-pod() {
    menu=$(kubectl get pod --all-namespaces | grep -i $1)
    value=$(get_option "$menu")
    namespace=$(echo $value | awk '{print $1}')
    pod=$(echo $value | awk '{print $2}')
    command="kubectl describe pod -n $namespace $pod"
    echo "RUN: "$command
    eval $command
}

alias k8s-run-test='kubectl delete pod dummy && kubectl run -i --tty dummy --image=centos:7 --restart=Never -- bash'
