# The Movie DB Viewer

Филмов каталог със собствена рейтинг система.

# Елементи на приложението:

* Начален екран - списък от филми подредени по популярност от The Movie DB. Списъкът се обновява с по-малко популярни филми при скролиране. Търсачка за филм. Всеки филм изобразен на началният екран съдържа:
 * Име на филма;
 * Съкратено описание на филма според пространството;
 * Дата на пускане;
 * Обложка.
* Детайли на филм - съдържа информацията от началният екран, но с цялото описание на филма, както и звезди, които могат да бъдат натиснати за да бъде оценен филмът от потребителите на това приложение.

# Технически елементи:
* [The Movie DB API](https://www.themoviedb.org/documentation/api?language=en-US) и [пълната документация](https://developers.themoviedb.org/3/authentication/how-do-i-generate-a-session-id) - ще се използва /discover и /search. Лимитът на рекуести е до 40 за 10 секунди за IP адрес. Няма нужда от аутентикация (/authenticate).
* [Firebase Realtime Database](https://firebase.google.com/docs/database/ios/start)

Финален проект за ИД "Програмиране за iOS със Swift" 2019/2020
