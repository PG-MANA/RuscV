# RuscV
(Format:UTF-8)  
Rustで書かれたRisc-V CPUで起動する何か

## 対応命令セット
* RISC-V

## ライセンス
Copyright 2019 PG_MANA  

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## 追加のライセンス
## ruscv.resc
ruscv.rescは https://github.com/renode/renode/blob/master/scripts/single-node/sifive_fe310.resc を利用しています。  

The MIT License (MIT)

Copyright (c) Antmicro <www.antmicro.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## ビルド
### 環境整備
必要なソフトウェア

* make
* riscv64-elf-gcc(RISC-V向けクロスビルド用GCC)
* cargo-xbuild

### ビルド

```shell
make
#これでbin/kernel.elfができています

make clean
#中間ファイル削除
```

## コーディング規約
基本は https://doc.rust-lang.org/1.1.0/style/style/naming/README.html に従ってください。
コード整形はrustfmtを使用します。  
(本人が守れてないかも)

## リンク
### 開発者のTwitterアカウント
  [https://twitter.com/PG_MANA_](https://twitter.com/PG_MANA_)
### 開発者のWebページ
  https://pg-mana.net
