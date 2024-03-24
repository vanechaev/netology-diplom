# netology-diplom - черновик

1. В отдельной папке (prep) создал тераформ котрый создает сервисную учетку и бакет ![](media/prep1.png)
2. В основной папке (terraform) сделал vpc и проинициализировал с данными из backend.key `terraform init -backend-config="access_key=***" -backend-config="secret_key=***"`
3. Destroy & Apply отработали корректно ![](media/tf-app.png) ![](media/tf-des.png)
4. Использовал манифесты: `ansible.tf`, `vm-masters.tf`, `vm-workers.tf`
5. Установил kubespray в `./ansible/kubespray`
```shell
wget https://github.com/kubernetes-sigs/kubespray/archive/refs/tags/v2.21.0.tar.gz
tar -xvzf v2.21.0.tar.gz
mv kubespray-2.21.0 kubespray
python3 -m pip install --upgrade pip
pip3 install -r kubespray/requirements.txt
```
6. Запустил `terraform apply --auto-approve` ![](media/ans-done.png)
7. Проверил кластер ![](media/cluster-test1.png) ![](media/cluster-test2.png)
8. Создал репозиторий для приложения https://github.com/vanechaev/testapp.git
9. Скачал, забилдил и запушил: ![](media/test-app1.png) ![](media/test-app2.png)
10. Развернул мониторинг в кластере `./terraform/monitoring.tf` используя helm и поднял сервис  `./k8s/s-grafana.yaml`
11. Подготовил network_load_balancer для доступа к grafana и testapp `./terraform/balance.tf`
12. Настроил развертывание в k8s тестового приложения `./terraform/app.tf` ![](media/nlb.png)  ![](media/db-graf.png)  ![](media/app-80.png)
13. Подготовил для агента манивест `./terraform/cicd.tf` он отрабатывает но не устанавливается...

