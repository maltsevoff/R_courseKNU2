Дані для лабораторної роботи містяться за посиланням:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Cтворити один R-скрипт, який називається run_analysis.R, який виконує наступні дії.

1. Об’єднує навчальний та тестовий набори, щоб створити один набір даних.

train_data <- read.table("/Users/user/Downloads/UCI HAR Dataset/train/X_train.txt")
test_data <- read.table("/Users/user/Downloads/UCI HAR Dataset/test/X_test.txt")
all_data <- rbind.data.frame(train_data, test_data)

2. Витягує лише вимірювання середнього значення та стандартного відхилення (mean and standard deviation) для кожного вимірювання.

features_df <- read.table("/Users/user/Downloads/UCI HAR Dataset/features.txt")
column_ids <- features_df[str_detect(features_df$V2, "mean") | str_detect(features_df$V2, "std"), 1]
mean_std_df<-all_data[, column_ids]

3. Використовує описові назви діяльностей (activity) для найменування діяльностей у наборі даних.


y_train <- read.table("/Users/user/Downloads/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("/Users/user/Downloads/UCI HAR Dataset/test/y_test.txt")

act_code <- c(1, 2, 3, 4, 5, 6)
act_name <- c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 
             'SITTING', 'STANDING', 'LAYING')
map_df <- data.frame(V1=act_code, activity_name=act_name)

y_train <- left_join(y_train, map_df, by = "V1")
y_test <- left_join(y_test, map_df, by = "V1")
all_activities  <- rbind.data.frame(y_train, y_test)

4. Відповідно присвоює змінним у наборі даних описові імена.

names(mean_std_df) <- features_df[str_detect(features_df$V2, "mean") | str_detect(features_df$V2, "std"), 2]

5. З набору даних з кроку 4 створити другий незалежний акуратний набір даних (tidy dataset) із середнім значенням для кожної змінної для кожної діяльності 
та кожного суб’єкту (subject).

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
all_subject <- rbind.data.frame(subject_train, subject_test)

df <- cbind.data.frame(subject=all_subject$V1, activity_name=all_activities$activity_name, 
                                mean_std_df)

res_df <- df %>% group_by(subject, activity_name) %>% summarise_all(mean)

write.table(res_df, file = "tidy_dataset.txt", row.names = FALSE)

