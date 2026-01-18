# OEC2026 Practice

- All documents can be found in `./docs/`

## Flowcharts

- Flowcharts were made in [Obsidian](https://obsidian.md/)
- If you want to view them open the root project as an Obsidian vault

## How to run it

### Docker (Web) - EASIEST

- You will need Docker or Podman installed
- Worse performance than native

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

### Flutter (Native)

- You will need the [Flutter SDK](https://docs.flutter.dev/install) installed
- Better performance than the web version

```bash
flutter run --release
```