# Задачи первого этапа
- [ ] Аутентификация логин пароль  - желательно LDAP
- [ ] Заказы
- [ ] Движение по заказу наименование - сумма 
- [ ] Продукты/BOM  - смотрелось бы эффектно и как часть еще одной насущной задачи предприятия



# Manuals and how to
## Имплементация бутсрап 
http://railscasts.com/episodes/328-twitter-bootstrap-basics?view=asciicast


# Предложения по использованию gem
## Аутентификация 
gem devise
http://railscasts.com/episodes?utf8=%E2%9C%93&search=devise

вроде умеет с LDAP

## Права 
gem cancan


# Загрузка продуктов
rails runner [-e envname] lib/import_products.rb lib/Book1.csv
