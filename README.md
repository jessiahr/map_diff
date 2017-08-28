# MapDiff

## Installation

```elixir
def deps do
  [{:map_diff, "~> 0.1.0"}]
end
```
## Usage
```elixir
MapDiff.diff(%{a: 1, b: 1}, %{a: 1, b: 2}) # -> %{b: [1, 2]}
```
