# Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
from argparse import ArgumentTypeError
from pathlib import Path


class PathType(object):
    def __init__(self, exists: bool = True, path_type: str = 'file'):
        """
        Argparse argument type to validate pathlib Paths.

        :param exists
            If True, ensure path exists.
            If False, ensure path does not exist.
            If None, do not validate the current state of the path.
        :param path_type If `exists` is True, validate "file", "dir", or None to not check.
        """
        assert exists in (True, False, None)
        assert path_type in ('file', 'dir', None)

        self._exists = exists
        self._type = path_type

    def __call__(self, argument: str) -> Path:
        path = Path(argument)
        if self._exists is None:
            pass
        elif self._exists:
            if not path.exists():
                raise ArgumentTypeError("path does not exist: '{}'".format(argument))
            elif self._type == 'dir' and not path.is_dir():
                raise ArgumentTypeError("path is not a directory: '{}'".format(argument))
            elif self._type == 'file' and not path.is_file():
                raise ArgumentTypeError("path is not a regular file: '{}'".format(argument))
        else:
            if path.exists():
                raise ArgumentTypeError("path already exists: '{}'".format(argument))
        return path
