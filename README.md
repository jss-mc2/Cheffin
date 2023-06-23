# Cheffin

Mini Challenge 2 Project

## Requirement

- Install Swiftgen via Homebrew [https://github.com/SwiftGen/SwiftGen](Swiftgen)
- Install SwifLint via Homebrew [https://github.com/realm/SwiftLint](SwiftLint)
---
## Tech Best Practice

### Version Control (GIT)

- Gunakan Semantic Commit message pada pesan commit.
  - Avaliable options:
    - feat -> New Feature
    - fix -> Fixing a bug
    - docs -> Update Documentations
    - style -> Theme / Assets
    - refactor -> Refactoring code
    - perf -> Performance Improvement
    - test -> Testing
    - build -> Build
    - ci -> CI / CD
    - chore -> Other task
    - revert -> Reverting a commit
  - Contoh: `feat: add recipe handler`
- Branching Strategy menggunakan branch `staging` sebagai branch utama.
- Gunakan prefix dibawah ini setiap pembuatan branch.
  - `feature/{your_name}_{task}` -> New Feature
  - `fix/{your_name}_{task}` -> Bugfixing
- Ketika Branch ready untuk merge, silahkan buat Pull Request dan isi templatenya sesuai dengan yang dibutuhkan.
- Ketika pembuatan Pull Request, wajib melalui Review terlebih dahulu, jangan lupa add other tech team as reviewer.
- Pembuatan Nama PR juga harus mengikuti Semantic Commit Message seperti di atas.
- Ketika commit pastikan TIDAK ADA WARNING/ERROR pada code.

### Coding

- Tampilan menggunakan SwiftUI
- UIViewController digunakan untuk `hosting` SwiftUI.
- Setiap perubahan Assets & Localize, Jalankan perintah `swiftgen` di Terminal.
- Ketika ada warning dari Linter, jalankan perintah `swiftlint --fix --format` di Terminal.
- Ketika warning tidak bisa di solve otomatis oleh swiftlint, lakukan fixing manual.
- Jangan buat class saling Coupling, gunakan Dependency Injection yg telah disediakan (Swinject).
