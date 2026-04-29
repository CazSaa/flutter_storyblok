# Contributing

## Publishing

Two packages: `flutter_storyblok` (root) and `flutter_storyblok_code_generator` (`code_generator/`). The generator depends on the root, so publish in this order.

### 1. Bump versions

- `pubspec.yaml` — bump `version`.
- `code_generator/pubspec.yaml` — bump `version` and (if applicable) the `flutter_storyblok` constraint.
- Update both `CHANGELOG.md` files.

### 2. Disable local override

In `code_generator/pubspec.yaml`, comment out the `dependency_overrides` block. **Do not commit this** — re-enable it after publishing for local development.

### 3. Publish root

```shell
dart pub publish
```

### 4. Wait for pub.dev to index

Generator's dry-run will fail with `version solving failed` until the new root version appears on pub.dev. Usually under a minute.

### 5. Publish generator

```shell
cd code_generator
dart pub publish
```

### 6. Restore local override

Uncomment the `dependency_overrides` block in `code_generator/pubspec.yaml`.
