## Дипломный проект в Yandex.Cloud - Нечаев Владимир.

---

### Задание

[Ссылка на дипломный практикум](https://github.com/netology-code/devops-diplom-yandexcloud/blob/780e41858bcff72855d9c3aa06733287b368c623/README.md)

---

### Выполнение

<details>
<summary>Создание облачной инфраструктуры</summary>

1. Создал сервисный аккаунт в Yandex.Cloud с достаточными правами.
   
   - Создаем аккаунт `yc iam service-account create --name sa-dip`
   - Назначаем права `yc resource-manager folder add-access-binding default --role admin --subject serviceAccount:===++ aje*-из предыдущей команды ++===`
   - Получаем ключ `yc iam key create --folder-name default --service-account-name sa-dip --output key.json`

2. Сделал terraform который создаст специальную сервисную учетку `tf-dip` и бакет для terraform backend в основном проекте [в отдельной папке](./prep/) и запустил его
   
`terraform apply --auto-approve`

![](media/prep1.png)

![](media/bucket.png)

3. Сделал основновной манифест terraform с VPC и запустил его используя ключи из backend.key (из предыдущего шага) [в папке terraform](./terraform/)

`terraform init -backend-config="access_key=***" -backend-config="secret_key=***"`

`terraform apply --auto-approve`

![](media/net.png)

`terraform destroy` и `terraform apply` отработали коректно

![](media/net.png)

![](media/net.png)

</details>

<details>
<summary>Задание 2. Установка и настройка локального kubectl</summary>
    
1. Установить на локальную машину kubectl.
2. Настроить локально подключение к кластеру.
3. Подключиться к дашборду с помощью port-forward.

</details>

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
12. Настроил развертывание в k8s тестового приложения `./terraform/testapp.tf` ![](media/nlb.png)  ![](media/db-graf.png)  ![](media/app-80.png)
13. Подготовил для агента манивест `./terraform/cicd.tf` он отрабатывает но не устанавливается...

