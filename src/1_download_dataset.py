from pathlib import Path
import shutil
import tomllib
import kagglehub


def load_config(config_path: Path) -> dict:
    """
    Loads the configuration from a TOML file.

    Args:
        config_path (Path): The path to the configuration file.
    Returns:
        dict: The configuration dictionary.
    """
    with open(config_path, "rb") as config_file:
        config = tomllib.load(config_file)
    return config


def download_dataset(dataset_name: str) -> str:
    """
    Downloads a dataset from Kaggle using kagglehub.

    Args:
        dataset_name (str): The name of the dataset to download.
        download_path (Path): The path where the dataset will be downloaded.
    """
    path = kagglehub.dataset_download(handle=dataset_name, force_download=True)
    return path


def move_dataset(src_path: Path, dest_path: Path) -> None:
    """
    Moves the downloaded dataset to the specified destination path.

    Args:
        src_path (Path): The source path of the downloaded dataset.
        dest_path (Path): The destination path where the dataset will be moved.
    """
    dest_path.mkdir(parents=True, exist_ok=True)

    files_from_dataset = Path(src_path).glob("*.csv")

    for file in files_from_dataset:
        dest_file_path = dest_path / file.name
        shutil.move(file, dest_file_path)
    

if __name__ == "__main__":
    config = load_config(Path("config.toml"))
    dataset_name = config["raw"]["files"][0]["name"]
    download_path = Path(config["raw"]["path"])
    downloaded_path = download_dataset(dataset_name)
    move_dataset(downloaded_path, download_path)