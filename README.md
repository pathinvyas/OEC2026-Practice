# OEC2026 Practice

- All documents can be found in `./docs/`

## Flowcharts

- Flowcharts were made in [Obsidian](https://obsidian.md/)
- If you want to view them open the root project as an Obsidian vault

# How to run it

## Prebuilt Binaries - RECOMMENDED

- Windows and Linux binaries only

[Download](https://github.com/pathinvyas/OEC2026-Practice/releases/latest)

## Docker (Web)

- You will need Docker or Podman installed
- Works on pretty much every platform
- Worse performance than native app

#### 1. Build Image
```bash
docker build -t oec2026-web-tethys .
```
#### 2. Run Image
```bash
docker run -p 8080:80 --rm oec2026-web-tethys
```
#### 3. Open the App
[localhost:8080](http://localhost:8080)
#### 4. Delete Image
```bash
docker image rm oec2026-web-tethys
```

## Flutter

- You will need the [Flutter SDK](https://docs.flutter.dev/install) installed
- Works on all platforms that Flutter supports

```bash
flutter run --release
```
