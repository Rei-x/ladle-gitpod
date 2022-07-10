var config = {
      server: {
        open: "none",
        hmr: {
				clientPort: process.env.HMR_HOST ? 443: 24678,
				host: process.env.HMR_HOST ? process.env.HMR_HOST.substring("https://".length) : "localhost"
			}
      },
}

export default config;