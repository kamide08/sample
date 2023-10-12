#include <stdio.h>
#include <unistd.h>
#include <curl/curl.h>

size_t WriteCallback(void *contents);
int main(void)
{
    CURL *curl;
    CURLcode res;

    // Curlの初期化
    curl = curl_easy_init();
    if (curl)
    {
        // URLを設定
        curl_easy_setopt(curl, CURLOPT_URL, "http://localhost:3000/matches/10?token=abc");
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        // データの取得などのオプションを設定

        while (1)
        {
            getchar();
            // リクエストの実行
            res = curl_easy_perform(curl);

            if (res != CURLE_OK)
            {
                fprintf(stderr, "Curl error: %s\n", curl_easy_strerror(res));
            }
        }
    }
    curl_easy_cleanup(curl);
    return 0;
}

size_t WriteCallback(void *contents)
{
    // コールバック関数が受け取るパラメータ

    char *data = (char *)contents; // データを文字列として扱うためにキャスト

    // 受信データを標準出力に出力
    printf("%s", data);
    FILE *fp = fopen("data.text", "w");
    if (fp == NULL)
    {
        perror("ファイルを開く際にエラーが発生しました");
        return 1;
    }
    fprintf(fp, "%s", data);
    fclose(fp);
    return 0;
}
