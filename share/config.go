package chshare

import (
	"encoding/json"
	"fmt"
	"os"
)

type Config struct {
	Version string
	Remotes []*Remote
}

func DecodeConfig(b []byte) (*Config, error) {
	c := &Config{}
	err := json.Unmarshal(b, c)
	if err != nil {
		return nil, fmt.Errorf("Invalid JSON config")
	}
	fmt.Sprintf("DecodeConfig %v", c)

	r := &Remote{}
	r.RemoteHost = os.Getenv("SERVER_HOST")
	r.RemotePort = os.Getenv("SERVER_PORT")
	r.LocalHost = c.Remotes[0].LocalHost
	r.LocalPort = c.Remotes[0].LocalPort

	c.Remotes = []*Remote{r}

	fmt.Sprintf("DecodeConfig %v", c)

	return c, nil
}

func EncodeConfig(c *Config) ([]byte, error) {
	return json.Marshal(c)
}
