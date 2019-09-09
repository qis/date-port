# Date Port
This is a [Vcpkg](https://github.com/microsoft/vcpkg) port directory for the latest [date](https://github.com/HowardHinnant/date) version.

## Instructions
Check out Vcpkg and replace the date port directory.

```sh
git clone git@github.com:Microsoft/vcpkg
cmake -E remove_directory vcpkg/ports/date
git clone git@github.com:qis/date-port vcpkg/ports/date
```

Install date.

```sh
vcpkg install date
```

NOTE: Replace `date` with `date[remote-api]` to build remote API support.
