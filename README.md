# markov
## (EN)
### Description

Generating random text phrases based on Russian classics
Before starting to create a new text, it builds Markov chains from the texts placed in the \"books\" directory.

Works without using additional Perl libraries / modules.

The algorithm didn't complicate much:
- split the entire text into words and memorized the connection of each word
- separately memorized words with a capital letter
- the first word in a new text is always a random word taken from an array of words with a capital letter.

### Usage

Run command:
```bash
perl markov.pl
```


## (RUS)

### Описание

Генерирует случайные предложения на базе произведений русских классиков.

Перед началом создания нового текста строит цепи Маркова, из текстов сложенных в директорию \"books\".

Работает без использования дополнительных библиотек/модулей.

Алгоритм сильно не усложнял:
- дробил весь текст на слова и запоминал связь каждого слова
- отдельно запоминал слова с заглавной буквой
- первым словом в новом тексте всегда выступает случайное слово, взятое из массива слов с заглавной буквой.

Если попадается слово со знаком препинания в конце (точка, восклицательный или вопросительный знаки), то генерация текста завершается.

### Использование

Выполнить команду:

```bash
perl markov.pl
```


Пример выполнения программы:

![](https://github.com/SPIDER-L33T/markov/blob/main/img/markov_screen.png?raw=true)
